Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287552AbSA0Cp0>; Sat, 26 Jan 2002 21:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSA0CpM>; Sat, 26 Jan 2002 21:45:12 -0500
Received: from ns.suse.de ([213.95.15.193]:29189 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287552AbSA0Co7>;
	Sat, 26 Jan 2002 21:44:59 -0500
Date: Sun, 27 Jan 2002 03:44:58 +0100
From: Andi Kleen <ak@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] sg in lk 2.5.3-pre5
Message-ID: <20020127034458.A8992@wotan.suse.de>
In-Reply-To: <3C53643E.47EDB3C2@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C53643E.47EDB3C2@torque.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2002 at 09:21:50PM -0500, Douglas Gilbert wrote:
> Strange that Andi Kleen had problems compiling ide-scsi, 
> it compiled and worked on my UP and SMP machines (AMD and
> dual Celeron respectively).

I must apologize. It seems the removal of scatterlist->address 
was a vger tree only change (I tested with vger).  Mainline
2.5 still seems to have it. Nevertheless the patch probably
won't hurt to apply.

-Andi
