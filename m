Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbTDWSlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTDWSlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:41:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:18649 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264236AbTDWSlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:41:40 -0400
Date: Wed, 23 Apr 2003 11:43:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2
Message-ID: <1538380000.1051123399@flay>
In-Reply-To: <200304231253.09520.habanero@us.ibm.com>
References: <Pine.LNX.4.44.0304231816210.10779-100000@localhost.localdomain> <1535810000.1051120075@flay> <200304231253.09520.habanero@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >  - turn off the more agressive idle-steal variant. This could fix the
>> >    low-load regression reported by Martin J. Bligh.
>> 
>> Yup, that fixed it (I tested just your first version with just that
>> bit altered).
> 
> Can we make this an arch specific option?  I have a feeling the HT performance 
> on low loads will actually drop with this disabled.  

Is it really an arch thing? Or is it a load level thing? I get the feeling
it might be switchable dynamically, dependant on load ...

M.

