Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTBTKoc>; Thu, 20 Feb 2003 05:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbTBTKob>; Thu, 20 Feb 2003 05:44:31 -0500
Received: from ns.suse.de ([213.95.15.193]:1285 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261364AbTBTKob>;
	Thu, 20 Feb 2003 05:44:31 -0500
Date: Thu, 20 Feb 2003 11:54:35 +0100
From: Andi Kleen <ak@suse.de>
To: dada1 <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, Simon Kirby <sim@netnation.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       davem@redhat.com
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030220105435.GD10374@wotan.suse.de>
References: <20030219174757.GA5373@netnation.com.suse.lists.linux.kernel> <p73r8a3xub5.fsf@amdsimf.suse.de> <20030220092043.GA25527@netnation.com> <20030220093422.GA16369@wotan.suse.de> <006301c2d8c8$921c1d10$760010ac@edumazet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006301c2d8c8$921c1d10$760010ac@edumazet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes IP is best-effort. But this argument cant explain why IP on linux works
> better if we disable SMP on linux...

It has nothing to do with SMP. The lazy locking dropping packets can happen
on UP kernels too in extreme cases. Also with preempt.

-Andi
