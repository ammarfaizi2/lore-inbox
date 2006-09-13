Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWIMRqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWIMRqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWIMRqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:46:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:40881 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750837AbWIMRqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:46:30 -0400
Message-Id: <20060913174312.528491000@chello.nl>
User-Agent: quilt/0.45-1
Date: Wed, 13 Sep 2006 19:43:12 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       Jason Baron <jbaron@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 0/2] new bd_mutex lockdep annotation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--

Andrew thought the old bd_mutex lockdep annotations were too complex, 
Arjan too said something like this several weeks ago and suggested I do
something with lockdep_set_class() instead of mutex_lock_nested().

