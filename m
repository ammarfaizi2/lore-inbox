Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTF3PBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTF3PBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:01:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17794 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264987AbTF3PBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:01:44 -0400
Subject: Re: Evaluation of three I/O schedulers
From: Dave Hansen <haveblue@us.ibm.com>
To: Peter Wong <wpeter@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Mike Sullivan <mksully@us.ibm.com>,
       Bill Hartner <bhartner@us.ibm.com>, Ray Venditti <venditti@us.ibm.com>
In-Reply-To: <OF9393D547.0D1D003C-ON85256D55.004DFAA4@pok.ibm.com>
References: <OF9393D547.0D1D003C-ON85256D55.004DFAA4@pok.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056986151.25479.3.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jun 2003 08:15:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-30 at 07:21, Peter Wong wrote:
> The 8-way machine has Pentium 4 2.0 GHz processors, 16 GB physical
> memory, 2MB L3 cache, 8 FC controllers with 80 disks. Hyperthreading
> was turned on for the three runs. The CPU utilization is similar for all
> three runs: 65% user, 7% system and 28% idle.

Could you give us an idea of how greatly utilized your 10 fiber
controllers are?  What about memory?  Would a larger readahead be
beneficial?

-- 
Dave Hansen
haveblue@us.ibm.com

