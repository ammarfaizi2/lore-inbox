Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWJDAmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWJDAmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWJDAmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:42:53 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:30586 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161036AbWJDAmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:42:53 -0400
Subject: Re: hrtimers bug message on 2.6.18-rt4
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: john stultz <johnstul@us.ibm.com>
Cc: Clark Williams <williams@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1159922315.14866.2.camel@localhost>
References: <45214EDC.6060706@redhat.com>
	 <1159811130.5873.5.camel@localhost.localdomain>
	 <1159921845.1979.9.camel@dwalker1.mvista.com>
	 <1159922315.14866.2.camel@localhost>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 17:42:51 -0700
Message-Id: <1159922571.1979.11.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 17:38 -0700, john stultz wrote:

> > With ltpstess . It has a settimeofday test which can trigger it. It gets
> > called with wild values.
> 
> Hmmm... That sounds like a false positive, where Ingo's time warp
> checking code isn't resetting on settimeofday() calls.
> 

Yeah, I think it is, but I figured I'd report it anyway ..

Daniel

