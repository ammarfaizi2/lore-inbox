Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTL2GWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 01:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTL2GWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 01:22:18 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:13713 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262767AbTL2GWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 01:22:17 -0500
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
Date: Mon, 29 Dec 2003 00:22:14 -0600
User-Agent: KMail/1.5.94
References: <Pine.LNX.4.44.0312281806070.3217-200000@eglifamily.dnsalias.net>
In-Reply-To: <Pine.LNX.4.44.0312281806070.3217-200000@eglifamily.dnsalias.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312290022.14411.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 December 2003 12:14 pm, dan@eglifamily.dnsalias.net wrote:
> Ok. After being without power for the past few days due to record
> snowfall, I'm alive again. So I made the changes people had recomended on
> the list. Upgraded to the lastest module-init-tools, and disabled the
> frame buffer support in the kernel. So the only graphic option enabled is
> text mode selection. But when I boot I still get a blank screen!
>
> My lilo.conf contains a line: vga=773, which works beautifully under
> RedHat's stock 2.4.20-8. I get a nice screen with approximately 132x48
> display. Under 2.4.20 I am not loading any frame buffer that I'm aware of.
> It's not listed in my moduiles:
>

Just a suggestion, but why not use vga=normal, which is text mode, instead of 
graphics.  You don't get the boot logo, but it does give you all the boot 
messages on 80x24.  I have been having the same issues, with an Nvidia card, 
and I decided it wasn't worth spending any time on it, since I really just 
wanted to see the messages, not any pictures.

Paul
