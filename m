Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262727AbTCPTDn>; Sun, 16 Mar 2003 14:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbTCPTDn>; Sun, 16 Mar 2003 14:03:43 -0500
Received: from holomorphy.com ([66.224.33.161]:46294 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262727AbTCPTDm>;
	Sun, 16 Mar 2003 14:03:42 -0500
Date: Sun, 16 Mar 2003 11:14:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1
Message-ID: <20030316191409.GK20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <20030316113254.GH20188@holomorphy.com> <200303161242.h2GCg1PO001746@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303161242.h2GCg1PO001746@eeyore.valparaiso.cl>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> said:
>> Another thought I had was wrapping things in structures for both small
>> and large, even UP systems so proper typechecking is enforced at all
>> times. That would probably need a great deal of arch sweeping to do,
>> especially as a number of arches are UP-only (non-SMP case's motive #2).

On Sun, Mar 16, 2003 at 08:42:01AM -0400, Horst von Brand wrote:
> AFAIU, gcc doesn't put structures in registers (even when they fit).

Bugreport and/or wishlist time.


-- wli
