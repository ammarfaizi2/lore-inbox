Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUEaNNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUEaNNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUEaNNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:13:44 -0400
Received: from dns1.vodatel.hr ([217.14.208.29]:3201 "EHLO dns1.vodatel.hr")
	by vger.kernel.org with ESMTP id S263743AbUEaNNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:13:43 -0400
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko.ursulin@zg.htnet.hr>
To: linux-kernel@vger.kernel.org
Subject: Re: MM patches (was Re: why swap at all?)
Date: Mon, 31 May 2004 15:13:32 +0200
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
References: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <200405291031.02564.vda@port.imtp.ilyichevsk.odessa.ua> <40B84C85.8010207@yahoo.com.au>
In-Reply-To: <40B84C85.8010207@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405311513.32930.tvrtko.ursulin@zg.htnet.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 May 2004 10:40, Nick Piggin wrote:

> It is a cocktail of cleanups, simplification, and enhancements. The
> main ones that applie here is my split active lists patch (search
> archives for details), and explicit use-once logic.

I didn't have time to personally test it but just want to share some thoughts. 
This kind of improvement is absolutely necessary for 2.6 to be usefull on the 
desktop. It continues to escape me how come that this kind of, almost, bugfix 
arrives so late during stable period.

Unfortunately it doesn't apply on top of Con's autoregulate swappines (AM from 
now on) which I am currently testing. AM also does an excellent job in 
preventing swap trashing while doing a lot of filesystem reading.

I am curious on how does your patch technically relates to Con's AM, and is it 
possible to merge the two? I know that they do their job on completely 
different ways, so the real question would be: Is there a need for something 
like AM if using your patch, or it completely obsoletes it?

