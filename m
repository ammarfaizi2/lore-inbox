Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTKICg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 21:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTKICg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 21:36:29 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:61970 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261950AbTKICg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 21:36:28 -0500
Date: Sun, 9 Nov 2003 03:36:25 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org, konsti@ludenkalle.de
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031109023625.GA15392@win.tue.nl>
References: <20031109011205.GA21914%konsti@ludenkalle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031109011205.GA21914%konsti@ludenkalle.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 02:12:05AM +0100, Konstantin Kletschke wrote:

> I have a PC here with an intel i875p chipset which seems not to recognize
> logical partititions. 2.4.18 (kernel bf24 image) boots fine, but i do
> not get a 2.6.0-test5 or 2.6.0-test9 to boot.
> 
> When booting Kernels report
> 
> hda: hda1 hda2 <hda5 hda6>
> 
> and boot, this one reports only:
> 
> hda: hda hda2

I suppose that second hda is a typo for hda1?

What partition table? (fdisk -l /dev/hda or sfdisk -l -x -uS /dev/hda)

