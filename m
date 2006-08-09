Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030694AbWHIL33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbWHIL33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030695AbWHIL33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:29:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40416 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030694AbWHIL32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:29:28 -0400
Date: Wed, 9 Aug 2006 12:29:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: merlin@sztaki.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about kill PIDTYPE_TGID patch
Message-ID: <20060809112922.GA15224@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, merlin@sztaki.hu,
	linux-kernel@vger.kernel.org
References: <200608091323.12426.merlin@sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091323.12426.merlin@sztaki.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 01:23:12PM +0200, merlin@sztaki.hu wrote:
> Hello,
> 
> I'm trying to compile IBM GPFS(2.3.0-15) Portability Layer with a 2.6.16 
> kernel (2.6.16-1.2289_FC6-xen-i686). The compiler stops with 
> the error message below:
> 
> kdump-kern.c:163: error: `PIDTYPE_TGID' undeclared (first use in this 
> function)
> 
> As I think, this is because of the PIDTYPE_TGID patch. 
> 
> I don't want to get out that patch from the kernel , if there's
> a more simple solution.
> 
> I hope you can suggest me a solution for the three lines where PIDTYPE_TGID
> appears (see below) in the source code.

Just stop using broken, propritary out of tree code.  If you refuse to
do that go to your IBM support contact and whine to them, it's their fault
after all.

