Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbUJ0FtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUJ0FtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUJ0FtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:49:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34712 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261656AbUJ0FtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:49:07 -0400
Date: Wed, 27 Oct 2004 07:47:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Mathieu Segaud <matt@minas-morgul.org>, jfannin1@columbus.rr.com,
       agk@redhat.com, christophe@saout.de, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-ID: <20041027054741.GB15910@suse.de>
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com> <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org> <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041026222650.596eddd8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26 2004, Andrew Morton wrote:
> Mathieu Segaud <matt@minas-morgul.org> wrote:
> >
> > Andrew Morton <akpm@osdl.org> disait dernièrement que :
> > 
> >  > If you have time, please restore dio-handle-eof.patch and then apply the
> >  > below fixup, then retest.  Thanks.
> > 
> >  I had time to test this fix; it did not solve the problem. Whereas reverting
> >  the complete dio-handle-eof.patch solved it.
> 
> bummer.  Can you send a super-simple means by which I can demonstrate the
> problem?

Hmm, maybe round the value up to a PAGE_SIZE in length?

-- 
Jens Axboe

