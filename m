Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVCYLNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVCYLNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 06:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVCYLNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 06:13:22 -0500
Received: from relay.muni.cz ([147.251.4.35]:59584 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261529AbVCYLNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 06:13:19 -0500
Date: Fri, 25 Mar 2005 12:13:06 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net
Subject: Re: drivers/block/ub.c and multiple LUNs
Message-ID: <20050325111306.GG18127@fi.muni.cz>
References: <20050321092520.4b2cb7c6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321092520.4b2cb7c6@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
: On Mon, 21 Mar 2005 12:42:45 +0100 Jan Kasprzak <kas@fi.muni.cz> wrote:
: 
: > is the ub.c USB storage driver supposed to work with multi-LUN(?) devices?
: 
: There's no reason why it won't, see the attached patch. I just need to
: send the patch to Greg Kroah one day.

	OK, thanks - it works for me with Tungsten T5. Sorry for the delayed
reply.

: > PS.: There is no MAINTAINERS file entry for the ub.c driver, and Pete Zaitcev
: > 	is not even listed in the CREDITS file.
: 
: I didn't think it was important, but I see now that if it helps to prevent
: the ub traffic from going to Matt, it ought to be done. I'll send a patch.

	Thanks!

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
