Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVCYOct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVCYOct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVCYOct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:32:49 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:60096 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261648AbVCYOcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:32:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=sNF31F+VYysYFwjmxVTZsBzv3wFXuVrxfd/PRfDz5Te3aW09IOaCF8AQcMLf5SBy4AglKTF0Jy9/4jjm0tj44YHcPt67C/Q5MteZJ/iIPCJLENJVIb2alcyj6tyqGKBiyut0iw6yN+CGvdnE8KTP9x02n99EgKpZb/jk9Z+1f7M=
Message-ID: <c25b253205032506321055bc56@mail.gmail.com>
Date: Fri, 25 Mar 2005 06:32:47 -0800
From: Richard Hubbell <richard.hubbell@gmail.com>
Reply-To: Richard Hubbell <richard.hubbell@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: CPU scheduler tests
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <20050325083224.GA23407@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <4243C243.10401@sw.ru> <20050325083224.GA23407@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 09:32:24 +0100, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Kirill Korotaev <dev@sw.ru> wrote:
> 
> > Can someone (Ingo?) recommend me CPU scheduler tests which are usually 
> > used to test CPU scheduler perfomance, context switch performance, 
> > SMP/migration/balancing performance etc.?
> 
> it's not really the microbenchmarks that matter (although they obviously 
> are part of the picture), but actual application performance. There are 
> dozens of workloads that matter. Kernel compilation timings are an 
> obvious priority :-), but there are other things like SPECsdet, STREAM, 
> dbt3-pgsql, kernbench, AIM7, various Java benchmarks and more.
> 
> now that scheduler changes have calmed down somewhat, we are mainly 
> looking for regressions, and are checking schedstats output to see how 
> 'healthy' a given workload behaves.

Do you keep the results available somewhere they can be browsed?

Richard
