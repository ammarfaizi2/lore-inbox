Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUGLX7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUGLX7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUGLX7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:59:44 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:36265 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264358AbUGLX7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:59:22 -0400
References: <200407121943.25196.devenyga@mcmaster.ca>
Message-ID: <cone.1089676751.66009.12958.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: Preempt Threshold Measurements
Date: Tue, 13 Jul 2004 09:59:11 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Devenyi writes:

> Keeping in mind that I'm using the nvidia-kernel drivers, here are my preempt 
> threshold violations.

Hi.

Thanks for those. Can you confirm which version of the preempt threshold 
patch you're using? The first one I posted unfortunately had false 
positives. Those results unfortunately look like the first patch.

You would have to be using either wli_preempttest2 + 2.1 separate patches or 
the snapshot-2.6.8-rc1-ck5-0407130047 or later which includes these patches 
for more accurate timekeeping (sorry).

Cheers,
Con

