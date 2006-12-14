Return-Path: <linux-kernel-owner+w=401wt.eu-S932077AbWLNIkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWLNIkj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWLNIkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:40:39 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:40508 "EHLO
	laptopd505.fenrus.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932077AbWLNIki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:40:38 -0500
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it
	possible to have restricted irqs
From: Arjan van de Ven <arjan@linux.intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <m1lklaooz1.fsf@ebiederm.dsl.xmission.com>
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
	 <m1lklbport.fsf@ebiederm.dsl.xmission.com> <20061213194332.GA29185@elte.hu>
	 <m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
	 <45806137.4020403@linux.intel.com>
	 <m11wn3p0zk.fsf@ebiederm.dsl.xmission.com>
	 <45810383.2060708@linux.intel.com>
	 <m1psamopjj.fsf@ebiederm.dsl.xmission.com>
	 <458109FA.3060304@linux.intel.com>
	 <m1lklaooz1.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Dec 2006 09:40:32 +0100
Message-Id: <1166085632.27217.967.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > the numa case of "I prefer that cpu" is handled. Not the "I cannot work on
> > those".
> 
> How is the NUMA case of I prefer that cpu handled?

it's exported via /sys/bus/pci/devices/<device>/local_cpus
(and the irq is in the /irq directory next to local_cpus)

