Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVFYVzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVFYVzi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 17:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFYVzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 17:55:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61394 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261338AbVFYVyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 17:54:35 -0400
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <55020000.1119733402@[10.10.2.4]>
References: <20050621130344.05d62275.akpm@osdl.org>
	 <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu>
	 <320710000.1119632967@flay> <20050624195248.GA9663@elte.hu>
	 <344410000.1119646572@flay> <20050625040052.GB4800@elte.hu>
	 <44570000.1119681732@[10.10.2.4]> <1119722905.5762.15.camel@mindpipe>
	 <55020000.1119733402@[10.10.2.4]>
Content-Type: text/plain
Date: Sat, 25 Jun 2005 17:54:33 -0400
Message-Id: <1119736473.15994.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-25 at 14:03 -0700, Martin J. Bligh wrote:
> I have no intent, nor method, of doing so. rdtsc is a direct instruction,
> without intervention, as I understand it.

I thought so too, but it turns out the CPU lets you disable it at boot.
This was suggested as a possible fix for the alleged hyperthreading
vulnerability.

Lee

