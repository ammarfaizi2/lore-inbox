Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUJONvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUJONvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJONuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:50:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8911 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267777AbUJONsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:48:01 -0400
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
	card BOOT?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
In-Reply-To: <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org>
	 <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097844301.9863.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 13:45:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-15 at 13:38, Geert Uytterhoeven wrote:
> Why not? Of course you won't get any output before the graphics card has been
> re-initialized to a sane and usable state...

That will depend on the system. The AMD64 boxes I have all allow the
bios to post the video card on S3 resume. 

For a lot of other stuff we can run the bios directly on the resume path
without emulation (or for intel call the video restore bios
int). For the rest this could be a useful weapon.

