Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWCUJRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWCUJRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWCUJRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:17:16 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:31202 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1750760AbWCUJRO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:17:14 -0500
From: CIJOML <cijoml@volny.cz>
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16 - cpufreq doesn't find Celeron (Pentium4/XEON) processor
Date: Tue, 21 Mar 2006 10:16:49 +0100
User-Agent: KMail/1.8.3
References: <200603210902.19335.cijoml@volny.cz> <1142931856.3077.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1142931856.3077.47.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603211016.49307.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am totally sure. It was cpufreq via normal P4/XEON - trottling doesn't work 
for me:

notas:/usr/src/linux-2.6.16# cat /proc/acpi/processor/CPU0/throttling
<not supported>


Michal

Dne út 21. bøezna 2006 10:04 jste napsal(a):
> On Tue, 2006-03-21 at 09:02 +0100, CIJOML wrote:
> > Hi,
> >
> > up to 2.6.15 my kernel worked to find my processor and frequency scalling
> > was possible via cpufreq. I have
>
> are you sure it was frequency scaling and not throttling? I thought real
> frequency scaling was only available on non-Celeron processors.....
> (and throttling isn't all that great for power save)
