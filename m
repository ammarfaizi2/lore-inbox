Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWEDXmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWEDXmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 19:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWEDXmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 19:42:09 -0400
Received: from web.bloglines.com ([65.214.39.152]:44219 "HELO
	blw06bos.io.askjeeves.info") by vger.kernel.org with SMTP
	id S1030280AbWEDXmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 19:42:08 -0400
Message-ID: <1146786127.1525598216.32201.sendItem@bloglines.com>
Date: 4 May 2006 23:42:07 -0000
From: grfgguvf.29601511@bloglines.com
To: adaplas@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird framebuffer bug?
MIME-Version: 1.0
Content-Type: text/plain;charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Antonino A. Daplas <adaplas@gmail.com> wrote:
> Does the same thing happens
with different color depths?
> 
> Can you try using the "vesa" driver with
X?  If the same thing happens, it might
> be a problem with the BIOS.
>


I will check these later.

> 
> BTW, what does dmesg and fbset -i say?

>

% dmesg | egrep -i 'frame|fb|vesa|nv'
 BIOS-e820: 0000000007fff000
- 0000000008000000 (ACPI NVS)
Security Framework v1.0.0 initialized
vesafb:
framebuffer at 0xf0000000, mapped to 0xb8880000, using 6144k, total 32768k

vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected
mode interface info at c000:c060
vesafb: scrolling: redraw
vesafb: Truecolor:
size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device
128x48
fb0: VESA VGA frame buffer device

# fbset -i

mode "1024x768-76"

    # D: 78.653 MHz, H: 59.949 kHz, V: 75.694 Hz
    geometry 1024 768 1024
768 32
    timings 12714 128 32 16 4 128 4
    rgba 8/16,8/8,8/0,8/24
endmode


Frame buffer device information:
    Name        : VESA VGA
    Address
    : 0xf0000000
    Size        : 6291456
    Type        : PACKED PIXELS

    Visual      : TRUECOLOR
    XPanStep    : 0
    YPanStep    : 0
 
  YWrapStep   : 0
    LineLength  : 4096
    Accelerator : No


> Tony

> 
> PS: I'll be traveling in a few hours, so I may not be able to answer
back.
> 

Well thank you for answering so far then.
This is not urgent
you can answer tomorrow or at any later time.
