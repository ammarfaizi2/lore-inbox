Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284807AbRL1X7d>; Fri, 28 Dec 2001 18:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284837AbRL1X7Y>; Fri, 28 Dec 2001 18:59:24 -0500
Received: from are.twiddle.net ([64.81.246.98]:41959 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S284807AbRL1X7K>;
	Fri, 28 Dec 2001 18:59:10 -0500
Date: Fri, 28 Dec 2001 15:59:07 -0800
From: Richard Henderson <rth@twiddle.net>
To: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha  - how to fill the PC
Message-ID: <20011228155907.A30611@twiddle.net>
Mail-Followup-To: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1008508796.18634.8.camel@satan.xko.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008508796.18634.8.camel@satan.xko.dec.com>; from aneesh.kumar@digital.com on Sun, Dec 16, 2001 at 06:49:56PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 06:49:56PM +0530, Aneesh Kumar K.V wrote:
> Right now I am doing ret_from_sys_call(&regs).

Err, ret_from_sys_call is not a function that can be called in
any normal method.  Supposing that you get there, the stack 
must be set up properly, and the stack is whence the register
values are fetched.


r~
