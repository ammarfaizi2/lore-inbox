Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbSJBVhv>; Wed, 2 Oct 2002 17:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262614AbSJBVhv>; Wed, 2 Oct 2002 17:37:51 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:245 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S262611AbSJBVhu>; Wed, 2 Oct 2002 17:37:50 -0400
Date: Wed, 2 Oct 2002 17:43:20 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH]  4KB stack + irq stack for x86
Message-ID: <20021002174320.J28857@redhat.com>
References: <3D9B62AC.30607@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9B62AC.30607@us.ibm.com>; from haveblue@us.ibm.com on Wed, Oct 02, 2002 at 02:18:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 02:18:36PM -0700, Dave Hansen wrote:
> I've resynced Ben's patch against 2.5.40.  However, I'm getting some 
> strange failures.  The patch is good enough to pass LTP, but 
> consistently freezes when I run tcpdump on it.

Try running tcpdump with the stack checking patch applied.  That should 
give you a decent backtrace for the problem.

		-ben
