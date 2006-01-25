Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWAYJnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWAYJnU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWAYJnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:43:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3493 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751089AbWAYJnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:43:19 -0500
Subject: Re: [RFC] VM: I have a dream...
From: Lee Revell <rlrevell@joe-job.com>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1138181033.4800.4.camel@tara.firmix.at>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
	 <1138181033.4800.4.camel@tara.firmix.at>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 04:42:58 -0500
Message-Id: <1138182179.3087.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 10:23 +0100, Bernd Petrovitsch wrote:
> 
> ACK. X, evolution and Mozilla family (to name standard apps) are the
> exceptions to this rule. 

If you decrease RLIMIT_STACK from the default 8MB to 256KB or 512KB you
will reduce the footprint of multithreaded apps like evolution by tens
or hundreds of MB, as glibc sets the thread stack size to RLIMIT_STACK
by default.

Lee

