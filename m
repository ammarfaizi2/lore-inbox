Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTJXHYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTJXHYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:24:14 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:6063 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262040AbTJXHYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:24:06 -0400
Message-ID: <3F98D3E6.60202@t-online.de>
Date: Fri, 24 Oct 2003 09:25:26 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031011
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: jani@iv.ro, jani@astechnix.ro
Subject: tridentfb 2.6.0* broken for VIA integrated graphics core on EPIA
 Mini-ITX boards
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: Vrinl0ZQwezchSPStcx3teqdK-Ct-Vebl9tKW3bhxKgd-LjmFREIwB@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

tridentfb stopped working on an EPIA Mini-ITX boards (VIA Eden cpu,  VIA 
8601A
North Bridge, VT 8231 South Bridge).

SuSE kernel 2.4.20 reports:

Oct 24 08:27:04 epia kernel: tridentfb: Trident framebuffer 0.7.5 
initializing
Oct 24 08:27:04 epia kernel: tridentfb: framebuffer size = 8192 Kb
Oct 24 08:27:04 epia kernel: tridentfb: Trident Microsystems 
CyberBlade/i1 board found
Oct 24 08:27:04 epia kernel: Console: switching to colour frame buffer 
device 80x25
Oct 24 08:27:04 epia kernel: tridentfb: fb0: Trident frame buffer device 
640x400-8bpp

tridentfb of 2.4.20 works fine.



Kernel 2.6.0-test8-bk3 reports:

Oct 24 08:25:24 linux kernel: tridentfb: Trident framebuffer 
0.7.8-NEWAPI initializing
Oct 24 08:25:24 linux kernel: tridentfb: framebuffer size = 8192 Kb
Oct 24 08:25:24 linux kernel: tridentfb: 0000:01:00.0 board found
Oct 24 08:25:24 linux kernel: tridentfb: probe of 0000:01:00.0 failed 
with error -22

No difference if compiled as a module or compiled directly into kernel.
Vesafb is usable but slow.

Any ideas?

cu
 Knut

