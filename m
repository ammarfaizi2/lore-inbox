Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVB1Voo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVB1Voo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVB1VnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:43:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:939 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261768AbVB1VnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:43:00 -0500
Subject: Re: user space program from keyboard driver
From: Lee Revell <rlrevell@joe-job.com>
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0502282118480.2017@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502282118480.2017@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 16:21:15 -0500
Message-Id: <1109625676.9273.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 21:24 +0530, Payasam Manohar wrote:
> hai all,
>     I am a newbie to kernel, I want to work on linux kernel modules.
> My task is to call a user program from keyboard driver under certain 
> conditions. I know that we can call user program using 
> call_usermodehelper(), but we can not call it direcly from driver as it is 
> a interrupt context. So we need to call using schedule_work(). But I need 
> more clarification on these points. How to call user program from the 
> keyboard driver. Please give ur ideas for doing this.
> 

Are you just trying to write a keystroke logger?

Lee

