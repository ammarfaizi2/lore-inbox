Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264168AbTDWR41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTDWR41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:56:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4503 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264168AbTDWR40 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:56:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2
Date: Wed, 23 Apr 2003 12:53:09 -0500
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.44.0304231816210.10779-100000@localhost.localdomain> <1535810000.1051120075@flay>
In-Reply-To: <1535810000.1051120075@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304231253.09520.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 April 2003 12:47, Martin J. Bligh wrote:
> >  - turn off the more agressive idle-steal variant. This could fix the
> >    low-load regression reported by Martin J. Bligh.
>
> Yup, that fixed it (I tested just your first version with just that
> bit altered).

Can we make this an arch specific option?  I have a feeling the HT performance 
on low loads will actually drop with this disabled.  

-Andrew
