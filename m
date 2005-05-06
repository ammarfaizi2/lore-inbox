Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVEFKoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVEFKoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 06:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVEFKoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 06:44:23 -0400
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:64220 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261206AbVEFKoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 06:44:20 -0400
Subject: Re: [PATCH] enable CONFIG_RTAS_PROC by default
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, johnrose@austin.ibm.com, linux-kernel@vger.kernel.org,
       anton@samba.org
In-Reply-To: <17019.3651.107704.631078@cargo.ozlabs.ibm.com>
References: <17018.51064.311305.718975@cargo.ozlabs.ibm.com>
	 <1115343066.6503.6.camel@localhost.localdomain>
	 <17019.3651.107704.631078@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 06 May 2005 06:43:35 -0400
Message-Id: <1115376216.6421.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 16:27 +1000, Paul Mackerras wrote:
> Arjan van de Ven writes:
> 
> > shouldn't this move over to sysfs at some point, to some firmware
> > directory ?
> 
> Well, eventually maybe, but there are userspace programs using it, so
> we can't remove the /proc interface for a while yet.

sure that's a given, the question is I guess first to start providing a
sysfs equivalent so that apps CAN start using the new thing, before even
thinking about the obsoletion of the old interface. That was more what I
was fishing for ...




