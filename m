Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWCHCIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWCHCIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCHCIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:08:37 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21927 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752013AbWCHCIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:08:36 -0500
Subject: Re: [PATCH] mm: yield during swap prefetching
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ck@vds.kolivas.org
In-Reply-To: <200603081228.05820.kernel@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
	 <200603081212.03223.kernel@kolivas.org>
	 <20060307172337.1d97cd80.akpm@osdl.org>
	 <200603081228.05820.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 21:08:30 -0500
Message-Id: <1141783711.767.121.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 12:28 +1100, Con Kolivas wrote:
> I can't distinguish between when cpu activity is important (game) and when it 
> is not (compile), and assuming worst case scenario and not doing any swap 
> prefetching is my intent. I could add cpu accounting to prefetch_suitable() 
> instead, but that gets rather messy and yielding achieves the same endpoint. 

Shouldn't the game be running with RT priority or at least at a low nice
value?

Lee

