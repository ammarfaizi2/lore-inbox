Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTEHNXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEHNXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:23:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:46602 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261408AbTEHNXa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:23:30 -0400
Date: Thu, 8 May 2003 15:39:08 +0200
To: Jens Axboe <axboe@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030508133908.GA824@hh.idb.hist.no>
References: <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no> <20030508080135.GK8978@holomorphy.com> <20030508100717.GN8978@holomorphy.com> <3EBA4529.7050507@aitel.hist.no> <20030508120450.GT823@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508120450.GT823@suse.de>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 02:04:50PM +0200, Jens Axboe wrote:
> On Thu, May 08 2003, Helge Hafting wrote:
> > William Lee Irwin III wrote:
> > 
> > >2.5.69-mm3 should suffice to test things now. If you can try that when
> > >you get back I'd be much obliged.
> > 
> > 2.5.69-mm3 died in exactly the same way - the oops was identical.
> > I'm back to running mm2 without netfilter, to see how
> > stable it is.
> 
> See my mail to rusty, I'm seeing the same thing. Back out the changeset
> that wli pasted here too, and it will work.
> 
Much fuzz and two rejects.  Seems there is ongoing netfilter
work in mm3.

Helge Hafting
