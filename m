Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSJYSvW>; Fri, 25 Oct 2002 14:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbSJYSvW>; Fri, 25 Oct 2002 14:51:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:20355 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261545AbSJYSvV>;
	Fri, 25 Oct 2002 14:51:21 -0400
Date: Fri, 25 Oct 2002 11:52:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: chrisl@vmware.com
cc: linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?
Message-ID: <485770000.1035571959@flay>
In-Reply-To: <20021025182023.GA1397@vmware.com>
References: <20021024230229.GA1841@vmware.com> <2897727591.1035509219@[10.10.2.3]> <20021025182023.GA1397@vmware.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ones are paired up, I believe that if all but the last bit
>> of the apicid is the same, they're siblings. You might have to
>> dig the apicid out of the bootlog if the cpuinfo stuff doesn't
>> tell you.
> 
> And you are right. Those apicid, after mask out the siblings,
> are put in phys_cpu_id[] array in kernel.

Probably best to just hack /proc/cpuinfo output to include the apicid.

M.

