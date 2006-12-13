Return-Path: <linux-kernel-owner+w=401wt.eu-S965118AbWLMUCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWLMUCV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWLMUCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:02:20 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:49808 "EHLO
	laptopd505.fenrus.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965088AbWLMUCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:02:19 -0500
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it
	possible to have restricted irqs
From: Arjan van de Ven <arjan@linux.intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <m1lklbport.fsf@ebiederm.dsl.xmission.com>
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
	 <m1lklbport.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Dec 2006 21:02:11 +0100
Message-Id: <1166040131.27217.888.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> .
> 
> In addition the cases I can think of allowed_affinity is the wrong
> name.  suggested_affinity sounds like what you are trying to implement
> and when it is merely a suggestion and not a hard limit it doesn't
> make sense to export like this.

it really IS a hard limit. 

