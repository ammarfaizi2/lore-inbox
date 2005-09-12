Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVILJyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVILJyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVILJyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:54:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4267 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751272AbVILJyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:54:54 -0400
Date: Mon, 12 Sep 2005 02:54:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: nikita@clusterfs.com, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset semaphore depth check deadlock fix
Message-Id: <20050912025425.332fa8ba.pj@sgi.com>
In-Reply-To: <20050912024747.2ba6d39b.pj@sgi.com>
References: <20050909220116.26993.9674.sendpatchset@jackhammer.engr.sgi.com>
	<17186.35554.43089.674075@gargle.gargle.HOWL>
	<20050912024747.2ba6d39b.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The global owner was insufficient because it wasn't

Oops - meant to say:

> The global depth was insufficient because it wasn't

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
