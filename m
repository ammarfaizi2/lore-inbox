Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWFPLUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWFPLUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWFPLUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:20:40 -0400
Received: from ns2.suse.de ([195.135.220.15]:18367 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751167AbWFPLUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:20:39 -0400
From: Andi Kleen <ak@suse.de>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT tasks.
Date: Fri, 16 Jun 2006 13:20:34 +0200
User-Agent: KMail/1.9.3
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com> <200606161236.50302.ak@suse.de> <20060616195807.84fc0b97.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060616195807.84fc0b97.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161320.34443.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Should we send signal (kill or stop) to tasks whose cpus_allowed only contains
> removed cpu rather than simple migration ?

At least as a sysctl option it probably makes sense yes.

-Andi
