Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVDKL4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVDKL4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVDKL4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:56:20 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:2464 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261789AbVDKL4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:56:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VPJCCJFxOWIJbAodcnbsM90jDOGQHaZSl2JwcNrVc/pJLgHm/6pTfQ5Lx6rk+QvaRvrusQv+QgRIrnDLYWQabyzlYbqEWTmbSgpGpu96qLk3naKElsZn802YwcCOn+cqhskO5/jzvs44blL/I8G6hVy96Id8nf+4xH622rr3K4g=
Message-ID: <58cb370e05041104564b4fce10@mail.gmail.com>
Date: Mon, 11 Apr 2005 13:56:14 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: kus Kusche Klaus <kus@keba.com>
Subject: Re: RT 45-01: CF Card read: High latency?
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231EA@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <AAD6DA242BC63C488511C611BD51F3673231EA@MAILIT.keba.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11, 2005 1:38 PM, kus Kusche Klaus <kus@keba.com> wrote:

> So the question is, what exactly is the IDE priority?
> Is the PIO transfer done in the IRQ handler or in a bh?

in the IRQ handler
