Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUJCAAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUJCAAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 20:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUJCAAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 20:00:39 -0400
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:21187 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S267638AbUJCAAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 20:00:38 -0400
Message-ID: <415F4121.2030308@bigpond.net.au>
Date: Sun, 03 Oct 2004 10:00:33 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: dipankar@in.ibm.com, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, mbligh@aracnet.com, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <415F3D4C.6060907@watson.ibm.com>
In-Reply-To: <415F3D4C.6060907@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
>> be a possible solution.  Of course, this proposed modification 
>> wouldn't make any sense with less than 3 CPUs.
> 
> 
> Why ? It is even useful for 2 cpus.
> Currently cpumem sets do not enforce that there is not intersections 
> between siblings of a hierarchy.

There's only 3 non empty sets and only one of them can have a CPU 
removed from the set without becoming empty.  So the pain wouldn't be 
worth the gain.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
