Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264809AbSJVRlJ>; Tue, 22 Oct 2002 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbSJVRkg>; Tue, 22 Oct 2002 13:40:36 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:39927 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264780AbSJVRiy>; Tue, 22 Oct 2002 13:38:54 -0400
Date: Tue, 22 Oct 2002 13:45:01 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <20021022134501.C20957@redhat.com>
References: <2629464880.1035240956@[10.10.2.3]> <Pine.LNX.4.44L.0210221405260.1648-100000@duckman.distro.conectiva> <20021022131930.A20957@redhat.com> <396790000.1035308200@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <396790000.1035308200@flay>; from mbligh@aracnet.com on Tue, Oct 22, 2002 at 10:36:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 10:36:40AM -0700, Martin J. Bligh wrote:
> Bear in mind that large pages are neither swap backed or file backed
> (vetoed by Linus), for starters. There are other large app problem scenarios 
> apart from Oracle ;-)

I think the fact that large page support doesn't support mmap for users 
that need it is utterly appauling; there are numerous places where it is 
needed.  The requirement for root-only access makes it useless for most 
people, especially in HPC environments where it is most needed as such 
machines are usually shared and accounts are non-priveledged.

		-ben
-- 
"Do you seek knowledge in time travel?"
