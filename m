Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290783AbSBLF56>; Tue, 12 Feb 2002 00:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290784AbSBLF5s>; Tue, 12 Feb 2002 00:57:48 -0500
Received: from are.twiddle.net ([64.81.246.98]:31877 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S290783AbSBLF5i>;
	Tue, 12 Feb 2002 00:57:38 -0500
Date: Mon, 11 Feb 2002 21:57:35 -0800
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
Message-ID: <20020211215735.B20458@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
	anton@samba.org, linux-kernel@vger.kernel.org,
	zippel@linux-m68k.org
In-Reply-To: <20020211.192334.123921982.davem@redhat.com> <15464.36074.246502.582895@napali.hpl.hp.com> <20020211212644.A20387@twiddle.net> <20020211.213248.48398226.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020211.213248.48398226.davem@redhat.com>; from davem@redhat.com on Mon, Feb 11, 2002 at 09:32:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 09:32:48PM -0800, David S. Miller wrote:
> BTW, your "4 issue" comments assume the cpu can do 4 non-FPU
> instructions per cycle, most I am aware of cannot and I think ia64
> even falls into the "cannot" category.  Doesn't it?

ia64 and alpha ev6 can do this easily.  They both have
four integer pipelines.


r~
