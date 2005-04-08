Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVDHG2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVDHG2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVDHG2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:28:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36798 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262702AbVDHG20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:28:26 -0400
Date: Fri, 8 Apr 2005 08:28:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com,
       inaky.perez-gonzalez@intel.com, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050408062811.GA19204@elte.hu>
References: <1112896344.16901.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112896344.16901.26.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> 	This patch adds the priority list data structure from Inaky 
> Perez-Gonzalez to the Preempt Real-Time mutex.

this one looks really clean.

it makes me wonder, what is the current status of fusyn's? Such a light 
datastructure would be much more mergeable upstream than the former 
100-queues approach.

	Ingo
