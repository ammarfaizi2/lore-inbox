Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVARPrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVARPrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVARPrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:47:13 -0500
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:8359 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S261331AbVARPpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:45:47 -0500
Message-ID: <41ED2F1F.1080905@bigpond.net.au>
Date: Wed, 19 Jan 2005 02:45:35 +1100
From: Cal <hihone@bigpond.net.au>
Reply-To: hihone@bigpond.net.au
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>,
       joq@io.com, rlrevell@joe-job.com, paul@linuxaudiosystems.com
Subject: Re: [ck] [PATCH][RFC] sched: Isochronous class for unprivileged soft
 rt	scheduling
References: <41ED08AB.5060308@kolivas.org>
In-Reply-To: <41ED08AB.5060308@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000003, version=0.93.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Comments and testing welcome.

There's a collection of test summaries from jack_test3.2 runs at
<http://www.graggrag.com/ck-tests/ck-tests-0501182249.txt>

Tests were run with iso_cpu at 70, 90, 99, 100, each test was run twice. 
The discrepancies between consecutive runs (with same parameters) is 
puzzling.  Also recorded were tests with SCHED_FIFO and SCHED_RR.

Before drawing any hardball conclusions, verification of the results 
would be nice. At first glance, it does seem that we still have that 
fateful gap between "harm minimisation" (policy) and "zero tolerance" 
(audio reality requirement).

cheers, Cal
