Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbTBOPVz>; Sat, 15 Feb 2003 10:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTBOPVz>; Sat, 15 Feb 2003 10:21:55 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:49326 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262446AbTBOPVy>; Sat, 15 Feb 2003 10:21:54 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200302151531.QAA01646@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
To: zwane@holomorphy.com (Zwane Mwaikambo)
Date: Sat, 15 Feb 2003 16:31:46 +0100 (MET)
Cc: weigand@immd1.informatik.uni-erlangen.de (Ulrich Weigand),
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <Pine.LNX.4.50.0302150924250.3518-100000@montezuma.mastecende.com> from "Zwane Mwaikambo" at Feb 15, 2003 09:29:19 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> +		if (cpu_online(i) && ((1UL << i) && mask))

That's still '&&' instead of '&'.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
