Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSBSV1P>; Tue, 19 Feb 2002 16:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290284AbSBSV1F>; Tue, 19 Feb 2002 16:27:05 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:64825 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S290259AbSBSV1B>;
	Tue, 19 Feb 2002 16:27:01 -0500
Date: Tue, 19 Feb 2002 22:26:59 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ENOTTY from ext3 code?
Message-ID: <20020219212659.GA5902@win.tue.nl>
In-Reply-To: <20020219190932.GA274@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020219190932.GA274@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 08:09:32PM +0100, Pavel Machek wrote:

> ext3/ioctl.c:
> 
> ...
> 	return -ENOTTY;
> 
> Does it really make sense to return "not a typewriter" from ext3
> ioctl?

I suppose you know the definition of ENOTTY?

Quoting POSIX:
[ENOTTY] Inappropriate I/O control operation.
