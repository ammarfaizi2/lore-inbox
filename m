Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267887AbUHETZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267887AbUHETZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267885AbUHESa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:30:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:7611 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267837AbUHESSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:18:09 -0400
Message-Id: <200408051817.i75IHD715692@owlet.beaverton.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error 
In-reply-to: Your message of "Thu, 05 Aug 2004 18:49:36 +0200."
             <20040805164936.GK2746@fs.tum.de> 
Date: Thu, 05 Aug 2004 11:17:13 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like it could happen if you compile without CONFIG_SMP ...
which admittedly I have not tried since the sched-domain code was
introduced.  Adrian, was this the situation in your case?

Rick
