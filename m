Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267591AbSLMBxk>; Thu, 12 Dec 2002 20:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267596AbSLMBxk>; Thu, 12 Dec 2002 20:53:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:36834 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267591AbSLMBxj>; Thu, 12 Dec 2002 20:53:39 -0500
Message-ID: <3DF93F2A.6090600@us.ibm.com>
Date: Thu, 12 Dec 2002 18:00:10 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [ANNOUNCE] kexec-tools-1.8
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>	<m1k7jb3flo.fsf_-_@frodo.biederman.org>	<m1el9j2zwb.fsf@frodo.biederman.org>	<m11y5j2r9t.fsf_-_@frodo.biederman.org>	<m1r8d1xcap.fsf_-_@frodo.biederman.org> <3DEC1758.8030302@us.ibm.com> <m18yz7y2qh.fsf@frodo.biederman.org>
In-Reply-To: <m18yz7y2qh.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got around to trying it on a NUMA-Q again.  It makes it well into 
the kernel this time.  I've been getting some strange CPU numbering 
problems, but that was happening to a lesser extent before I threw 
kexec in there.

Right now it's dying in the memory allocator, but that is probably 
just something that didn't get initialized right, or some cross-quad 
memory that isn't set up right.

I would really like to see this go into 2.5.  The fact that it gets 
this far on something as exotic as a NUMA-Q is a tribute to its 
maturity.
-- 
Dave Hansen
haveblue@us.ibm.com

