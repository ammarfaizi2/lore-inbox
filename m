Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTDIMFr (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 08:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTDIMFr (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 08:05:47 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:17134 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S263018AbTDIMFq (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 08:05:46 -0400
Date: Wed, 9 Apr 2003 08:13:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304090816_MC3-1-33A4-BDC1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ANdre Hedrick wrote:

>Does the broadcom driver have a test for who owns the intq?
>If it is eating the hpt370's interrupt, well you already see the picture.


 Using edge-triggered interrupts with sharing is a bad idea, no?


--
 Chuck
 I am not a number!
