Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbTDXJHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbTDXJHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:07:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9476 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262024AbTDXJHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:07:00 -0400
Date: Thu, 24 Apr 2003 10:19:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424101903.C9597@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@fenrus.demon.nl>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com> <1051174641.1385.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051174641.1385.4.camel@laptop.fenrus.com>; from arjan@fenrus.demon.nl on Thu, Apr 24, 2003 at 10:57:21AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:57:21AM +0200, Arjan van de Ven wrote:
> where it seems to say that if you need a script to be able to usefully
> install a self compiled kernel, that script is part of "the sourcecode".
> Now this of course can't and doesn't mean that people would need to give
> up their private keys to the public; said "script" of course can also
> install a second key or disable the keychecking. 
> 
> Or maybe I'm just totally interpreting this wrong.

You just arrange for the script to detect whether a private key is
present.  If none exists, it asks the user whether they want to generate
a private key, and then calls gpg with the relevant options to do so.

The private key isn't part of the script, nor is it a requirement to
be able to (successfully) run the script.

Note that the GPL does not say whether the output from the installation
script has to be usable with the target hardware.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

