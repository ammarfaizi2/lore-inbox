Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUC1EkC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 23:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUC1EkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 23:40:02 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:11438 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262100AbUC1Ej6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 23:39:58 -0500
Date: Sat, 27 Mar 2004 21:40:29 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328044029.GB1984@bounceswoosh.org>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <40661049.1050004@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 at  9:37, Nick Piggin wrote:
>I think 32MB is too much. You incur latency and lose
>scheduling grainularity. I bet returns start diminishing
>pretty quickly after 1MB or so.

32-MB requests are the best for raw throughput.

~15ms to land at your target location, then pure 50-60MB/sec for the .5
seconds it takes to finish the operation. (media limited at that point)

Sure, there's more latency, but I guess that is application dependant.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

