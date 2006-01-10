Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbWAJVH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWAJVH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWAJVH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:07:56 -0500
Received: from fmr21.intel.com ([143.183.121.13]:42171 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932691AbWAJVHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:07:55 -0500
Date: Tue, 10 Jan 2006 13:07:37 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>, Keith Owens <kaos@sgi.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text addres
Message-ID: <20060110130737.A14197@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060110203912.007577046@csdlinux-2.jf.intel.com> <20060110204045.712982192@csdlinux-2.jf.intel.com> <43C41CCE.8070208@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43C41CCE.8070208@grupopie.com>; from pmarques@grupopie.com on Tue, Jan 10, 2006 at 08:45:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 08:45:02PM +0000, Paulo Marques wrote:
> 
> This conflicts with a similar patch from Keith Owens earlier this week.
In fact I was the one who brought this issue to Keith and I missed seeing his
patch on the mailing list.

> I actually prefer Keith's version as it is the one which solves the bug 
> by changing as least as possible the current behavior.
That's fine, we can live with Keith's patch.
As long as the bug is solved, I am happy a man:-)

But my [patch 2/2] speeds up the lookup and that can go in, I think.
Please ack that patch if you think so.

-Anil

