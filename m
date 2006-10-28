Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWJ1D2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWJ1D2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 23:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWJ1D2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 23:28:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52896 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750794AbWJ1D17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 23:27:59 -0400
Subject: Re: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: thockin@hockin.org, Luca Tettamanti <kronos.it@gmail.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
In-Reply-To: <200610271804.52727.ak@suse.de>
References: <1161969308.27225.120.camel@mindpipe>
	 <20061027201820.GA8394@dreamland.darkstar.lan>
	 <20061027230458.GA27976@hockin.org>  <200610271804.52727.ak@suse.de>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 23:28:00 -0400
Message-Id: <1162006081.27225.257.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 18:04 -0700, Andi Kleen wrote:
> I don't think it makes too much sense to hack on pure RDTSC when 
> gtod is fast enough -- RDTSC will be always icky and hard to use.

I agree FWIW, our application would be happy to just use gtod if it
wasn't so slow on these machines.

Lee

