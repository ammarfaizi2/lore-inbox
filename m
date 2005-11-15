Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVKOWTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVKOWTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVKOWTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:19:35 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:5902 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932197AbVKOWTf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:19:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kKL+6uyeIIHOQqH4wxIKfokvceXGbMR0LtnzwU2uj1mQkCnJgsfnSnbZGx10l2ZCbGlsSrFrBB90Y9lBZ1/ik2AvPT3muXEKYbhken88aTGAkEM/Dm/XIdkglfRv/mH5kYTtppdvfdqHhYAfKFneOWxC1z9AlHmcyANK4w9qddg=
Message-ID: <eada2a070511151419j5d94ec55xb36c6ae7d17ea30a@mail.gmail.com>
Date: Tue, 15 Nov 2005 14:19:33 -0800
From: Tim Pepper <lnxninja@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] Add NUMA policy support for huge pages.
Cc: akpm@osdl.org, Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org, ak@suse.de,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.62.0511151342310.10995@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0511151342310.10995@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Christoph Lameter <clameter@engr.sgi.com> wrote:
> --- linux-2.6.14-mm2.orig/mm/mempolicy.c        2005-11-15 10:29:53.000000000 -0800
> +++ linux-2.6.14-mm2/mm/mempolicy.c     2005-11-15 12:30:26.000000000 -0800
> @@ -1005,6 +1005,34 @@ static unsigned offset_il_node(struct me
>         return nid;
>  }
>
> +/* Caculate a node number for interleave */
      ^^^^^

Calculate even...
