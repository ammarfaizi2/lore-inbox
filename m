Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWH3Ci5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWH3Ci5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 22:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWH3Ci5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 22:38:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47073 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751003AbWH3Ci4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 22:38:56 -0400
Date: Tue, 29 Aug 2006 19:38:28 -0700
From: Paul Jackson <pj@sgi.com>
To: paulmck@us.ibm.com
Cc: ego@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       arjan@infradead.org, rusty@rustcorp.com.au, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@intel.linux.com,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-Id: <20060829193828.d38395fe.pj@sgi.com>
In-Reply-To: <20060829200304.GF1290@us.ibm.com>
References: <20060824103417.GE2395@in.ibm.com>
	<1156417200.3014.54.camel@laptopd505.fenrus.org>
	<20060824140342.GI2395@in.ibm.com>
	<1156429015.3014.68.camel@laptopd505.fenrus.org>
	<44EDBDDE.7070203@yahoo.com.au>
	<20060824150026.GA14853@elte.hu>
	<20060825035328.GA6322@in.ibm.com>
	<20060827005944.67f51e92.pj@sgi.com>
	<20060829180511.GA1495@us.ibm.com>
	<20060829123102.88de61fa.pj@sgi.com>
	<20060829200304.GF1290@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> Let me throw something together...

I think it's the hotplug folks that were most interested
in this "unfair rwsem" lock, for lock_cpu_hotplug().

I wouldn't spend any effort on throwing this together
just for cpusets.  I'm not looking to change cpuset
locking anytime soon.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
