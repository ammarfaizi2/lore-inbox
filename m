Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWHHQ1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWHHQ1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWHHQ1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:27:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14541 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030186AbWHHQ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:27:02 -0400
Date: Tue, 8 Aug 2006 17:27:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [PATCH 3/3] Kprobes: Update Documentation/kprobes.txt
Message-ID: <20060808162701.GC28647@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	linux-kernel@vger.kernel.org,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Jim Keniston <jkenisto@us.ibm.com>
References: <20060807115537.GA15253@in.ibm.com> <20060807120024.GD15253@in.ibm.com> <20060807120447.GE15253@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807120447.GE15253@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 05:34:47PM +0530, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> Update Documentation/kprobes.txt to reflect addition of KPROBE_ADDR,
> KPROBE_RETVAL and the in-kernel symbol resolution.

Thanks.  With my updated patch we shouldn't document KPROBE_ADDR anymore
but tell people to always use the symbol_name mechanisms. 

Any chance to add some kerneldoc comments for the exported kprobes
functions?

