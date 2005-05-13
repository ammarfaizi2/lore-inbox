Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVEMGsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVEMGsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 02:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVEMGsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 02:48:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19626 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262262AbVEMGsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 02:48:51 -0400
Date: Fri, 13 May 2005 08:48:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sched.c: remove two unused functions
Message-ID: <20050513064835.GA21818@elte.hu>
References: <20050513004716.GR3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513004716.GR3603@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> This patch removes the unused functions wait_for_completion_timeout 
> and wait_for_completion_interruptible_timeout.
> 
> Is any usage for them planned or is this patch OK?

yes, there's usage planned and patches pending - to convert certain sort 
of semaphore-based completion code to real completion code.

	Ingo
