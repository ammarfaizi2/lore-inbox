Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTIITna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbTIITn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:43:29 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:64781
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264322AbTIITn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:43:27 -0400
Date: Tue, 9 Sep 2003 12:43:45 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: G?bor L?n?rt <lgb@lgb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-ID: <20030909194345.GD28279@matchmail.com>
Mail-Followup-To: G?bor L?n?rt <lgb@lgb.hu>, linux-kernel@vger.kernel.org
References: <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com> <3F578656.60005@namesys.com> <20030904132804.D15623@schatzie.adilger.int> <3F57AF79.1040702@namesys.com> <20030909130902.GE3944@openzaurus.ucw.cz> <20030909192107.GB22952@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909192107.GB22952@vega.digitel2002.hu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 09:21:07PM +0200, G?bor L?n?rt wrote:
> On Tue, Sep 09, 2003 at 03:09:02PM +0200, Pavel Machek wrote:
> > > Yup.  That's why we confine it to a (finite #defined number) set of 
> > > operations within one sys_reiser4 call.  At some point we will allow 
> > > trusted user space processes to span multiple system calls (mail 
> > > server applicances, database appliances, etc., might find this 
> > > useful).  You might consider supporting sys_reiser4 at some point.
> > 
> > 
> > Well, if you want that API to be widely usable, you should invent
> > better name than sys_reiser4 :-).
> 
> Like ActiveFSControll or such? ;-)

How about sys_group_journal_ops?
