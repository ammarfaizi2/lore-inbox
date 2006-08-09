Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030626AbWHIJ4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbWHIJ4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWHIJ4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:56:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:59540 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030625AbWHIJ4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:56:13 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] Kprobes: Define retval helper
Date: Wed, 9 Aug 2006 11:55:50 +0200
User-Agent: KMail/1.9.3
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-arch@vger.kernel.org
References: <20060807115537.GA15253@in.ibm.com> <20060809094311.GA20050@in.ibm.com> <20060809094516.GA17993@infradead.org>
In-Reply-To: <20060809094516.GA17993@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091155.50842.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  #define instruction_pointer(regs) ((regs)->eip)
> > +#define get_retval(regs) ((regs)->eax)

return_value() would match the names of the existing macro better

-Andi

