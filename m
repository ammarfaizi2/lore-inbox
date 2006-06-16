Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWFPJPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWFPJPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 05:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWFPJPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 05:15:05 -0400
Received: from mail.suse.de ([195.135.220.2]:4507 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750881AbWFPJPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 05:15:04 -0400
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT tasks.
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
From: Andi Kleen <ak@suse.de>
Date: 16 Jun 2006 11:14:57 +0200
In-Reply-To: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <p7364j1qx66.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> 
> This is a bit pessimistic. But forecd migration of RT task which is bounded
> to the special cpu will cause unpredictable trouble, I think.

More trouble than running it on a CPU that is about to fail?
Doubtful.

It seems like a case of "never check for an error you don't know
how to handle"

-Andi
