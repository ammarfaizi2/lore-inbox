Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVJUQyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVJUQyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVJUQx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:53:59 -0400
Received: from web25806.mail.ukl.yahoo.com ([217.12.10.191]:9847 "HELO
	web25806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965028AbVJUQx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:53:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vT6BJ2LscalQsy920ZfJID40fl3IGBIJNtsBHAmmxyUGwhC81zzWI08Mobt6Cz0S3Hzl+YFeRRDTtsaZMN2CQNQQXQDvGMUniG3ZWfXMvMxr6UrDotmshnFv8rmAEswn9vAa+sdtT8VXwesc6Y3SLU6wq9KVl7Xj+i9JLveKieI=  ;
Message-ID: <20051021165352.22654.qmail@web25806.mail.ukl.yahoo.com>
Date: Fri, 21 Oct 2005 18:53:52 +0200 (CEST)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
To: "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1ach3dj47.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Should the local_irq_disable() call go away onece
> local_irq_save() got
> > introduced.
> 
> Nope.  The irqs need to be disabled.  The save just
> allows this
> to be called in a context where irqs start out
> disabled.  It is
> just a save.

local_irq_save() also disables interrupts.

Cheers,
Albert




		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
