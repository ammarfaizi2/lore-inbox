Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271390AbTGQIri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271391AbTGQIri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:47:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:28826 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271390AbTGQIri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:47:38 -0400
Message-Id: <5.2.1.1.2.20030717110221.01a8d208@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 17 Jul 2003 11:06:41 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6.1int
Cc: Danek Duvall <duvall@emufarm.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200307171821.41886.kernel@kolivas.org>
References: <20030717080436.GA16509@lorien.emufarm.org>
 <200307171213.02643.kernel@kolivas.org>
 <200307171635.25730.kernel@kolivas.org>
 <20030717080436.GA16509@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:21 PM 7/17/2003 +1000, Con Kolivas wrote:
>On Thu, 17 Jul 2003 18:04, Danek Duvall wrote:
> > In 2.6.0-test1, the cc1 processes hover around 30 (early on they're
>
>That's weird, unless you nice 5 them they shouldn't get any higher than 25. A
>quick code review doesn't reveal to me why that would be the case.

Perhaps he has PRIO_BONUS_RATIO set to 50.

         -Mike 

