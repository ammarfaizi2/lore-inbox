Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284779AbRLKBzE>; Mon, 10 Dec 2001 20:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284810AbRLKByy>; Mon, 10 Dec 2001 20:54:54 -0500
Received: from zero.tech9.net ([209.61.188.187]:1287 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284808AbRLKByn>;
	Mon, 10 Dec 2001 20:54:43 -0500
Subject: Re: [PATCH] Make highly niced processes run only when idle
From: Robert Love <rml@tech9.net>
To: Ton Hospel <linux-kernel@ton.iguana.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9v3nvj$a99$1@post.home.lunix>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org>
	<1007939114.878.1.camel@phantasy>  <9v3nvj$a99$1@post.home.lunix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 10 Dec 2001 20:54:42 -0500
Message-Id: <1008035682.4287.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 20:36, Ton Hospel wrote:

> Please don't. Whenever you think you priority inheritance, it's a sign your 
> system has got too complicated. The simplest solution is to simply have no
> priorities when a task is in-kernel (or at least non that can completely
> exclude a task).

I agree, I said it was overkill.

My solution is going to be to schedule the task as a SCHED_OTHER task
when in the kernel, and as SCHED_IDLE task otherwise.

	Robert Love

