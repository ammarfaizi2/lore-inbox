Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbTEHJyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbTEHJyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:54:50 -0400
Received: from holomorphy.com ([66.224.33.161]:64150 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261315AbTEHJyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:54:49 -0400
Date: Thu, 8 May 2003 03:07:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030508100717.GN8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@digeo.com
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no> <20030508080135.GK8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508080135.GK8978@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 08:54:40AM +0200, Helge Hafting wrote:
>> Which patch is the netfilter cset?  None of
>> the patches in mm2 looked obvious to me.  Or
>> is it part of the linus patch? Note that mm1
>> works for me, so anything found there too
>> isn't as likely to be the problem.

On Thu, May 08, 2003 at 01:01:35AM -0700, William Lee Irwin III wrote:
> The fuzz/offset is safe. The netfilter patch to back out follows
> (there's actually a fix for it now but ignore that -- we just want
> to isolate the problem):

2.5.69-mm3 should suffice to test things now. If you can try that when
you get back I'd be much obliged.

Thanks


-- wli
