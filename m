Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbTEHHOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTEHHOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:14:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:36367 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261198AbTEHHOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:14:37 -0400
Date: Thu, 8 May 2003 09:30:11 +0200
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, linux-mm@kvack.org,
       akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030508073011.GA378@hh.idb.hist.no>
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508065440.GA1890@hh.idb.hist.no>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 08:54:40AM +0200, Helge Hafting wrote:
> On Wed, May 07, 2003 at 06:38:54PM -0700, William Lee Irwin III wrote:
> [...] 
> > Can you try one kernel with the netfilter cset backed out, and another
> > with the re-slabification patch backed out? (But not with both backed
> > out simultaneously).
> 
> I'm compiling without reslabify now.
The 2.5.69-mm2 kernel without reslabify died in the same way.
10 minutes of nethack and I got the same oops.
I'm not sure about netfilter, so I'll simply try a kernel
with the filter deselected.

Helge Hafting
