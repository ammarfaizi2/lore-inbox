Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281854AbRLVSxk>; Sat, 22 Dec 2001 13:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281910AbRLVSxb>; Sat, 22 Dec 2001 13:53:31 -0500
Received: from lsanca1-ar27-4-63-187-072.vz.dsl.gtei.net ([4.63.187.72]:23696
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S281854AbRLVSxT>; Sat, 22 Dec 2001 13:53:19 -0500
Date: Sat, 22 Dec 2001 10:53:10 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Chris Rankin <rankincj@yahoo.com>
cc: <tigran@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux IA32 microcode driver
In-Reply-To: <200112221258.fBMCwIVl005421@twopit.underworld>
Message-ID: <Pine.LNX.4.33.0112221050290.9843-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001, Chris Rankin wrote:

> Am I missing something rather obvious, or is the /dev/cpu/microcode
> device being mis-created under devfs with Linux 2.4.x? I have enclosed
> a patch to ensure that the character device really *is* a character
> device.

On my system, running 2.4.16, I get no devfs entry for that or msr at all.
I just get the mtrr entry.

This is with microcode and msr loaded as modules.

-- 
Ben Clifford     benc@hawaga.org.uk
http://www.hawaga.org.uk/ben/  GPG: 30F06950
webcam: http://barbarella.hawaga.org.uk/~benc/webcam/live.html

