Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWIUWA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWIUWA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWIUWA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:00:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17896 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750924AbWIUWA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:00:27 -0400
Date: Thu, 21 Sep 2006 14:59:46 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: sekharan@us.ibm.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060921145946.8d9ace73.pj@sgi.com>
In-Reply-To: <6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	<1158798715.6536.115.camel@linuxchandra>
	<20060920173638.370e774a.pj@sgi.com>
	<6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	<1158803120.6536.139.camel@linuxchandra>
	<6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	<1158869186.6536.205.camel@linuxchandra>
	<6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> But, there's no reason that the OpenVZ resource control mechanisms
> couldn't be hooked into a generic process container mechanism along
> with cpusets and RG.

Can the generic container avoid performance bottlenecks due to locks
or other hot cache lines on the main code paths for fork, exit, page
allocation and task scheduling?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
