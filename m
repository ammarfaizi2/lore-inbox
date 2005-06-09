Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVFIGfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVFIGfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVFIGeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:34:11 -0400
Received: from bay102-f32.bay102.hotmail.com ([64.4.61.42]:17026 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262280AbVFIGcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:32:51 -0400
Message-ID: <BAY102-F32EB4598D4BA3EA74F7E2AA0FC0@phx.gbl>
X-Originating-IP: [64.4.61.201]
X-Originating-Email: [hzmonte@hotmail.com]
In-Reply-To: <1118258722.4482.2.camel@localhost.localdomain>
From: "helen monte" <hzmonte@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: How does 2.6 SMP scheduler assign runqueues to multi-cores?
Date: Thu, 09 Jun 2005 06:32:47 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 09 Jun 2005 06:32:48.0262 (UTC) FILETIME=[0D982260:01C56CBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > By the way, in an SMT/hyperthreading processor, does the latest 
>kernel
> > > > version assign one run queue per physical CPU, or per virtual 
>processor?
> > > >
> > > one run-queue per physical CPU
> >
> > No. Each logical processor has its own runqueue.

How about muti-core?  Does each core also have its own run queue?  Does 
anyone know how multi-core would work with SMT?  Is it possible that they 
work together?  Is the following a possible scenario? :  A node has two 
processors, each processor has two cores, and each core has two "virtual 
cores". And there are 8 run queues in total.


