Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbSLDW12>; Wed, 4 Dec 2002 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbSLDW12>; Wed, 4 Dec 2002 17:27:28 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:11276 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267128AbSLDW10>; Wed, 4 Dec 2002 17:27:26 -0500
Date: Wed, 4 Dec 2002 20:34:27 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: kiran@in.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       akpm@digeo.com, dipankar@in.ibm.com
Subject: Re: [patch] Change Networking mibs to use kmalloc_percpu -- 1/3
Message-ID: <20021204223427.GA23578@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, kiran@in.ibm.com,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@digeo.com,
	dipankar@in.ibm.com
References: <20021204180510.C17375@in.ibm.com> <20021204.090152.97851491.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204.090152.97851491.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 04, 2002 at 09:01:52AM -0800, David S. Miller escreveu:
>    From: Ravikiran G Thirumalai <kiran@in.ibm.com>
>    Date: Wed, 4 Dec 2002 18:05:10 +0530
> 
>    Here's a patchset to enable networking mibs to use kmalloc_percpu instead
>    of the traditional padded NR_CPUS arrays.
>    
>    Advantages:
>    1. Removes NR_CPUS bloat due to static definition
>    2. Can support node local allocation
>    3. Will work with modules
>    
> I totally support this work.  Once the kmalloc percpu bits hit
> Linus's tree, just retransmit these diffs to me privately and
> I'll put them into my net-2.5 tree.

Cool stuff! I was planning to macroise this so that things like this would be
possible without source impact but now its just there, keep it up :-)

- Arnaldo
