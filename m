Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264873AbUEYO1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbUEYO1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 10:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbUEYO1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 10:27:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:55938 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264873AbUEYO1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 10:27:47 -0400
Date: Tue, 25 May 2004 07:27:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: FabF <fabian.frederick@skynet.be>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7rc1 vs 2.6.0
Message-ID: <367240000.1085495259@[10.10.2.4]>
In-Reply-To: <1085464727.3762.4.camel@localhost.localdomain>
References: <1085464727.3762.4.camel@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Here's trivial fgrep vs report (using ffb1) :
> 
> 2.6.7rc1 : 
> Grepping  /usr/bin  :
> 45% cpu - 38.06 RT Sec - 1.10 Sec in KM
> Entries scanned : 1527
> 85112 Kb analyzed this time
> 
> 2.6.0 : 
> Grepping  /usr/bin  :
> 51% cpu - 33.12 RT Sec - 1.10 Sec in KM
> Entries scanned :1527
> 85112 Kb analyzed this time
> 
> 	This is done against ext3 fs. Same .config, same box, same box state.
> What relevance could explain this 5s delta ? IOW, what big ext3, mm new functionnalities have been plugged in-between ?

Take kernel profiles of both (see Documentation/basic_profiling.txt)

M.

