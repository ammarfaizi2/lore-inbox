Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSGWQNG>; Tue, 23 Jul 2002 12:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318197AbSGWQNG>; Tue, 23 Jul 2002 12:13:06 -0400
Received: from server72.aitcom.net ([208.234.0.72]:4513 "EHLO test-area.com")
	by vger.kernel.org with ESMTP id <S318196AbSGWQNF>;
	Tue, 23 Jul 2002 12:13:05 -0400
Message-Id: <200207231616.MAA27336@test-area.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: anton wilson <anton.wilson@camotion.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] RML pre-emptive 2.4.19-ac2 with O(1)
Date: Tue, 23 Jul 2002 12:15:34 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207231756080.17062-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207231756080.17062-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +#if CONFIG_PREEMPT
> > +       /* Set the preempt count _outside_ the spinlocks! */
> > +       idle->preempt_count = (idle->lock_depth >= 0);
> > +#endif


This is the update I added.

Anton
