Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSJUQek>; Mon, 21 Oct 2002 12:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbSJUQek>; Mon, 21 Oct 2002 12:34:40 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:22449 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261512AbSJUQek>;
	Mon, 21 Oct 2002 12:34:40 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200210211640.UAA07235@sex.inr.ac.ru>
Subject: Re: UPD: Frequent/consistent panics in 2.4.19 at ip_route_input_slow, in_dev_get(dev)
To: alain@cscoms.net (Alain Fauconnet)
Date: Mon, 21 Oct 2002 20:40:16 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org, lve@ns.aanet.ru
In-Reply-To: <20021021100207.E302@cscoms.net> from "Alain Fauconnet" at Oct 21, 2 10:02:07 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> much   yet).   My   next   plan is to implement LKCD on the 2.4.17 box
> (not available for 2.4.19 yet as it  seems)  and  capture  a  complete
> crash dump. Would that help tracking down?

I do not think that this will help.

Try better to enable slab poisoning in slab.h. If it that thing
which I think of, it would provoke crash.

Alexey
