Return-Path: <linux-kernel-owner+w=401wt.eu-S1030236AbXAKOr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbXAKOr7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbXAKOr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:47:59 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:39542 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030236AbXAKOr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:47:58 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Tomas Carnecky <tom@dbservice.com>
Subject: Re: oprofile broken on 2.6.19
Date: Thu, 11 Jan 2007 15:47:48 +0100
User-Agent: KMail/1.9.5
Cc: Gert Vervoort <gert.vervoort@hccnet.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <45A3FF3E.7060109@hccnet.nl> <45A52320.2050100@hccnet.nl> <45A64BA1.2080403@dbservice.com>
In-Reply-To: <45A64BA1.2080403@dbservice.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701111547.48982.dada1@cosmosbay.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2007 15:37, Tomas Carnecky wrote:
> Gert Vervoort wrote:
> > Tomas Carnecky wrote:
> >> Gert Vervoort wrote:
> >>> When I try to use oprofile on 2.6.19, it does not seem to work:
> >>
> >> http://lkml.org/lkml/2006/11/22/172
> >
> > Disabling the nmi watchdog, as suggested in:
> > http://marc.theaimsgroup.com/?l=oprofile-list&m=116422889324043&w=2,
> > also makes oprofile work again.
>
> Oh.. that seem to be much easier then compiling a patched oprofile :)
> However, I can't find any NMI option (grep NMI .config), and
> CONFIG_WATCHDOG is disabled here.

Sure, but did you tried to boot with 'nmi_watchdog=0' appended in your boot 
params ?

Eric
