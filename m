Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTKIPxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTKIPxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:53:43 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:17028 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262297AbTKIPxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:53:42 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 9 Nov 2003 07:53:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
In-Reply-To: <121800000.1068392090@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0311090747110.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003, Martin J. Bligh wrote:

> I ran it on the 16-way - no difference in performance. If the code is 
> correct as was before (and I agree, it seems it was), perhaps it's just
> in need of a big fat comment to explain the confusion? ;-)

Ingo already dropped a fat comment ;) This is the relevant part:

 * We fend off statistical fluctuations in runqueue lengths by
 * saving the runqueue length during the previous load-balancing
 * operation and using the smaller one the current and saved lengths.
 


- Davide



