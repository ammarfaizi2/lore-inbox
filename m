Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVFKR2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVFKR2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVFKR2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:28:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55023 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261752AbVFKRZm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:25:42 -0400
Date: Sat, 11 Jun 2005 10:25:29 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <42AB1DD5.8010009@kolumbus.fi>
Message-ID: <Pine.LNX.4.10.10506111024460.27294-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2005, [ISO-8859-15] Mika Penttilä wrote:
> Not with !softirq_preemption, then we take the immediate path and 
> process soft irqs on irq exit.

My changes aren't used in that case.

Daniel

