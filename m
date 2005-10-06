Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVJFQ0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVJFQ0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVJFQ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:26:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11706 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751131AbVJFQ0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:26:31 -0400
Subject: Re: 2.6.14-rc3-rt9 - a few xruns misses
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510060900m721296h53ac1d0f0fc12351@mail.gmail.com>
References: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
	 <20051006083043.GB21800@elte.hu>
	 <5bdc1c8b0510060900m721296h53ac1d0f0fc12351@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 12:26:27 -0400
Message-Id: <1128615988.14584.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 09:00 -0700, Mark Knecht wrote:
> Even with Jack running I don't see the jackd process getting any
> special priority. Is this correct, or is that part that gets higher
> prioity just not listed here. 

ps does not show all threads of multithreaded processes by default.
Use:

ps -Leo pid,pri,rtprio,cmd

and you should see that 2 JACK threads get RT priority.

Lee



