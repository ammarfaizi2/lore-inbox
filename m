Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWC1WXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWC1WXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWC1WXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:23:36 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35224 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932452AbWC1WXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:23:35 -0500
Subject: Re: [PATCH 2.6.16-mm2] Kconfig SND_SEQUENCER_OSS help text fix
From: Lee Revell <rlrevell@joe-job.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060328134654.GA9671@silenus.home.res>
References: <20060328003508.2b79c050.akpm@osdl.org>
	 <20060328134654.GA9671@silenus.home.res>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 17:23:29 -0500
Message-Id: <1143584610.11792.101.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 15:46 +0200, Frederik Deweerdt wrote:
> Hi Andrew,
> 
> The SND_SEQUENCER_OSS config option in sound/core/Kconfig claims it could be 
> compiled as a module despite being a bool. This patch removes the misleading
> help text. This should apply to 2.6.16 as well, should I resend a patch?

But... it can be compiled as a module - I'm using it right now.

$ lsmod | grep ^snd_seq_oss
snd_seq_oss            31396  0 

Lee

