Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319161AbSIDM6n>; Wed, 4 Sep 2002 08:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319162AbSIDM6n>; Wed, 4 Sep 2002 08:58:43 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:50949 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319161AbSIDM6m>; Wed, 4 Sep 2002 08:58:42 -0400
Message-ID: <3D760494.7040805@namesys.com>
Date: Wed, 04 Sep 2002 17:03:16 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] mount flag "direct" (fwd)
References: <200209032107.g83L71h10758@oboe.it.uc3m.es> <3D75B344.66D4166@aitel.hist.no> <20020904083916.GX32468@clusterfs.com> <3D75F77B.9B0610F5@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think everyone agrees that you should start with doing it for a 
particular FS, and then after you have done it for one, you will know 
enough about what needs to be done that you can make your case that it 
should be done in VFS.  Frankly, I think that you should either share 
caches between nodes (NUMA), or (somehow, and there are so many ways...) 
divide the workload between the machines such that they don't access the 
same data except in response to failure.

Hans



