Return-Path: <linux-kernel-owner+willy=40w.ods.org-S285595AbUKASP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S285595AbUKASP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S285594AbUKASP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:15:57 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:19328 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S284719AbUKASEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:04:40 -0500
Subject: Re: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
From: Lee Revell <rlrevell@joe-job.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
References: <20041101084337.GA7824@dominikbrodowski.de>
	 <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 13:04:37 -0500
Message-Id: <1099332277.3647.43.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 07:00 -0700, Zwane Mwaikambo wrote:
> Agreed it makes a lot more sense, i think there could be some places where 
> we use preempt_disable to protect against cpu offline which could 
> converted, but that can come later.
> 

You know I picked up Robert Love's book the other day and was surprised
to read we are not supposed to be using preempt_disable, there is a
per_cpu interface for exactly this kind of thing.  Which is currently
recommended?

Lee

