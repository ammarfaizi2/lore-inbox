Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbTE1Tbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTE1Tbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:31:37 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:50777 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264839AbTE1Tbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:31:36 -0400
Date: Wed, 28 May 2003 12:44:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       cmm@us.ibm.com
Subject: Re: 2.5.70-mm1
Message-Id: <20030528124450.4dc532ad.akpm@digeo.com>
In-Reply-To: <3ED4ED6B.2010503@us.ibm.com>
References: <20030527004255.5e32297b.akpm@digeo.com>
	<3ED4ED6B.2010503@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 19:44:50.0841 (UTC) FILETIME=[9A55F890:01C32551]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> 
> I have run 50 fsx tests overnight on a 8 way PIII SMP box.  Each fsx 
> test reads/writes on it's own ext3 filesystem.  The 50 filesystems  
> spread over 10 disks.

Thanks for doing that.  I've found a couple of bugs which might explain two
of these.  I'll try the many-fsx test too.  -mm2 should be better.

