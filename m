Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbSI1EuZ>; Sat, 28 Sep 2002 00:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbSI1EuY>; Sat, 28 Sep 2002 00:50:24 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:48910 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S262722AbSI1EuY>; Sat, 28 Sep 2002 00:50:24 -0400
Date: Sat, 28 Sep 2002 00:54:39 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
In-Reply-To: <20020928043655.GU3530@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209280053590.32347-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, William Lee Irwin III wrote:

> On Sat, Sep 28, 2002 at 12:35:30AM -0400, Zwane Mwaikambo wrote:
> > Mine is a UP box not an SMP kernel, although preempt is enabled;
> > 0xc013d370 <fget>:      push   %ebx
> > 0xc013d371 <fget+1>:    mov    %eax,%ecx
> > 0xc013d373 <fget+3>:    mov    $0xffffe000,%edx
> > 0xc013d378 <fget+8>:    and    %esp,%edx
> > 0xc013d37a <fget+10>:   incl   0x4(%edx)
> 
> Do you have instruction-level profiles to show where the cost is on UP?

Unfortunately no, i was lucky to remember to even be running profile=n on 
this box.

-- 
function.linuxpower.ca

