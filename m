Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263709AbSIQGeJ>; Tue, 17 Sep 2002 02:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263712AbSIQGeJ>; Tue, 17 Sep 2002 02:34:09 -0400
Received: from smtpde02.sap-ag.de ([155.56.68.170]:41942 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S263709AbSIQGeJ>; Tue, 17 Sep 2002 02:34:09 -0400
Message-ID: <3D86CF0E.3090003@sap.com>
Date: Tue, 17 Sep 2002 08:43:26 +0200
From: Christoph Rohland <cr@sap.com>
Organization: SAP LinuxLab
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-mm@kvack.org,
       hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
References: <20020917044317.GZ2179@holomorphy.com> <3D86B683.8101C1D1@digeo.com> <20020917051501.GM3530@holomorphy.com> <3D86BE4F.75C9B6CC@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
> William Lee Irwin III wrote:
>>I went through the nodes by hand. It's just a run of the mill
>>ZONE_NORMAL OOM coming out of the GFP_USER allocation. None of
>>the highmem zones were anywhere near ->pages_low.
>>
>>
> 
> erk.  Why is shmem using GFP_USER?
> 
> mnm:/usr/src/25> grep page_address mm/shmem.c

For inode and page vector allocation.

Greetings
			Christoph



