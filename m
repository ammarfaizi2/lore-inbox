Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270819AbTGVMyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270820AbTGVMym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:54:42 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:28100 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S270819AbTGVMyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:54:41 -0400
Date: Tue, 22 Jul 2003 15:09:42 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Non-ASCII chars in visor.c messages
Message-ID: <20030722150941.E26218@fi.muni.cz>
References: <20030722143821.C26218@fi.muni.cz> <20030722125039.GA2310@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030722125039.GA2310@kroah.com>; from greg@kroah.com on Tue, Jul 22, 2003 at 08:50:39AM -0400
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
: > 
: > 	What do you think about it?
: 
: I don't think it's really needed.  Why change this, syslog can't handle
: this?  It works for me...
: 
	Yes, syslog can handle this, but in order to parse syslog files
you should have your LC_CTYPE set to something Latin-1 compatible
(which UTF-8 is not, and it is the default on many distros).

	Why Latin-1 and not UTF-8? I think UTF-8 is more "correct", while
ASCII is "works for all". Latin-1 is neither "correct" nor "works for all".

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|__ If you want "aesthetics", go play with microkernels. -Linus Torvalds __|
