Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbUCaWgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUCaWgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:36:41 -0500
Received: from mail.tpgi.com.au ([203.12.160.57]:24778 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262515AbUCaWgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:36:39 -0500
Subject: Re: [Swsusp-devel] [PATCH 2.6]: suspend to disk only available if
	non-modular IDE
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@suse.cz>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
In-Reply-To: <20040330201123.GE3084@openzaurus.ucw.cz>
References: <200403282136.55435.arekm@pld-linux.org>
	 <1080517040.2223.3.camel@laptop-linux.wpcb.org.au>
	 <20040330201123.GE3084@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1080772560.3081.0.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Thu, 01 Apr 2004 08:36:01 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-03-31 at 06:11, Pavel Machek wrote:
> Hi!
> 
> > Applied to 2.4 and 2.6.
> 
> Bad idea. For swsusp2 the patch is bad because it can resume from 
> after initrd (IIRC). For swsusp1 patch is bad
> because it should be able to resume
> from usb mass storage drive.

So long as the initrd doesn't mess our filesystems up, we should be
okay, shouldn't we?

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

