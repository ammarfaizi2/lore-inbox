Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVAMHXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVAMHXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 02:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVAMHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 02:23:15 -0500
Received: from holomorphy.com ([207.189.100.168]:58304 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261184AbVAMHXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 02:23:14 -0500
Date: Wed, 12 Jan 2005 23:19:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, torvalds@osdl.org, marcelo.tosatti@cyclades.com,
       greg@kroah.com, chrisw@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113071949.GA1226@holomorphy.com>
References: <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <20050112194239.0a7b720b.akpm@osdl.org> <20050113044942.GI14443@holomorphy.com> <20050112225412.5957c5d7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112225412.5957c5d7.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Most of the local DoS's I'm aware of are memory management -related,
>>  i.e. user- triggerable proliferation of pinned kernel data structures.

On Wed, Jan 12, 2005 at 10:54:12PM -0800, Andrew Morton wrote:
> Well.  A heck of a lot of the DoS opportunities we've historically seen
> involved memory leaks, deadlocks or making the kernel go oops or BUG with
> locks held or with kernel memory allocated.

I'd consider those even more severe.


-- wli
