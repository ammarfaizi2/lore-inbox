Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263401AbSJGQOf>; Mon, 7 Oct 2002 12:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263422AbSJGQOe>; Mon, 7 Oct 2002 12:14:34 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:2804 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S263408AbSJGQOe>; Mon, 7 Oct 2002 12:14:34 -0400
Date: Mon, 7 Oct 2002 12:20:13 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: nico@cam.org, rmk@arm.linux.org.uk, simon@baydel.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007122013.C5587@redhat.com>
References: <20021007125755.A5381@flint.arm.linux.org.uk> <Pine.LNX.4.44.0210071148450.913-100000@xanadu.home> <20021007.090233.107701780.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021007.090233.107701780.davem@redhat.com>; from davem@redhat.com on Mon, Oct 07, 2002 at 09:02:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 09:02:33AM -0700, David S. Miller wrote:
> I don't buy this one.  You are saying that the overhead of a procedure
> call is larger than the overhead of going out over the I/O bus to
> touch a device?

On slow CPUs like embedded 386es, yup.  Remember, they don't always have a 
cache.

		-ben
-- 
GMS rules.
