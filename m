Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266693AbUGLDBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266693AbUGLDBv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266694AbUGLDBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:01:51 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:59563 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266693AbUGLDBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:01:49 -0400
References: <200407112254.52032.devenyga@mcmaster.ca>
Message-ID: <cone.1089601296.571158.28499.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: mingo@elte.hu, ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: Voluntary Preempt + Ck5 Problems
Date: Mon, 12 Jul 2004 13:01:36 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Devenyi writes:

> Hi Guys,
> 
> Doing a non-scientific test of ck5 against 2.6.8-rc1 with ck5 and voluntary 
> preempt, it takes ~20 seconds to open konsole or kontact while running "make 
> -j30 all" on a linux-2.6.7 sourcetree. What kind of numbers do you need to 
> diagnose this issue. Please find my config attached.

What's the issue here? If your load is 30 it should take 30 times longer to 
happen. The fact it takes less than 30 times longer already is a good thing 
for you. There is no point trying to optimise for less than that.

Con

