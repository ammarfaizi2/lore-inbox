Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318269AbSGRQpg>; Thu, 18 Jul 2002 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318270AbSGRQpg>; Thu, 18 Jul 2002 12:45:36 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:64210 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318269AbSGRQpf>;
	Thu, 18 Jul 2002 12:45:35 -0400
Date: Thu, 18 Jul 2002 09:47:33 -0700
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020718164733.GA18988@krispykreme>
References: <3D361091.13618.16DC46FB@localhost> <41821596.1026977488@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41821596.1026977488@[10.10.2.3]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> shared pagetables
> large page support

Im not sure the complexity of shared pagetables is worth it. On ppc64
it will be a real pain to support since we rely on a 1:1 mapping between
linux and ppc64 ptes.

Unless its a large gain over using large pages (I doubt that will be the
case on sane chips with large TLBs) or conditional per architecture then
I think we should avoid it.

I do think we should get large page support in ASAP.

Anton
