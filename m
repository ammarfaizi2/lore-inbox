Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRJPIC4>; Tue, 16 Oct 2001 04:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273836AbRJPICq>; Tue, 16 Oct 2001 04:02:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4106 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273729AbRJPICh>; Tue, 16 Oct 2001 04:02:37 -0400
Subject: Re: VM
To: unknown@panax.com (Patrick McFarland)
Date: Tue, 16 Oct 2001 09:08:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011015211216.A1314@localhost> from "Patrick McFarland" at Oct 15, 2001 09:12:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15tPHE-0004zS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is the simple vm system still in place on the linus tree? I would think 
> the smart vm system in the ac tree would be better suited to .. oh.. say ..
>  everything. (The potential for less swapping is _always better_)

I've not reached any final conclusions on the VM - there are things that
Rik's VM shows up that look like the VM algorithm is right but it triggers
other stuff, and there are a couple of hackish bits left in still.

Smart is often good - especially given how slow disk seeks are. But smart is
not always best for any algorithm.

Alan
