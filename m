Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286150AbSAEAbf>; Fri, 4 Jan 2002 19:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286147AbSAEAbZ>; Fri, 4 Jan 2002 19:31:25 -0500
Received: from mailf.telia.com ([194.22.194.25]:17662 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S286145AbSAEAbV>;
	Fri, 4 Jan 2002 19:31:21 -0500
Message-Id: <200201050031.g050V7217956@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: <mingo@elte.hu>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Date: Sat, 5 Jan 2002 01:28:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201041238350.2247-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201041238350.2247-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fridayen den 4 January 2002 12.42, Ingo Molnar wrote:
> On Fri, 4 Jan 2002, Dieter [iso-8859-15] Nützel wrote:
> > What next? Maybe a combination of O(1) and preempt?
>
> yes, fast preemption of kernel-mode tasks and the scheduler code are
> almost orthogonal. So i agree that to get the best interactive performance
> we need both.
>
> 	Ingo
>
> ps. i'm working on fixing the crashes you saw.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Ingo,

The preemtion kernel adds protection to per process data...
And it is not (yet) updated to handle the O(1) scheduler!

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
