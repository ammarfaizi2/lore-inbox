Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285739AbRLHBt3>; Fri, 7 Dec 2001 20:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285740AbRLHBtT>; Fri, 7 Dec 2001 20:49:19 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:56250 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S285739AbRLHBtF>;
	Fri, 7 Dec 2001 20:49:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: "H. Peter Anvin" <hpa@zytor.com>, mjustice@austin.rr.com
Subject: Re: highmem question
Date: Fri, 7 Dec 2001 19:53:47 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719300102.00764@bozo> <3C116CC6.2030808@zytor.com>
In-Reply-To: <3C116CC6.2030808@zytor.com>
MIME-Version: 1.0
Message-Id: <01120719534703.00764@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> The problem is that in the x86 architecture you don't have any reasonable
> way of addressing the physical address space, so you need to map it into
> the virtual address space.  You end up with a shortage of virtual address
> space.

Isn't this still just an artifact of the default 1:3 kernel/user virtual 
address space split? I've never tried it myself but isn't there a 2:2 patch 
available that has the effect of moving the highmem boundary up?

>
> There is no way of fixing it.

All I know is that a streaming io app I was playing with showed a drastic 
performance hit when the kernel was compiled with CONFIG_HIGHMEM. On W2K we 
saw no slowdown with 2 or even 4GB of RAM so I think solutions must exist.

Marvin
