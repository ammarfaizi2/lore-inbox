Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTIITWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTIITVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:21:16 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:42944 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S264359AbTIITVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:21:10 -0400
Date: Tue, 9 Sep 2003 21:21:07 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-ID: <20030909192107.GB22952@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com> <3F578656.60005@namesys.com> <20030904132804.D15623@schatzie.adilger.int> <3F57AF79.1040702@namesys.com> <20030909130902.GE3944@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030909130902.GE3944@openzaurus.ucw.cz>
X-Operating-System: vega Linux 2.6.0-test3 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 03:09:02PM +0200, Pavel Machek wrote:
> > Yup.  That's why we confine it to a (finite #defined number) set of 
> > operations within one sys_reiser4 call.  At some point we will allow 
> > trusted user space processes to span multiple system calls (mail 
> > server applicances, database appliances, etc., might find this 
> > useful).  You might consider supporting sys_reiser4 at some point.
> 
> 
> Well, if you want that API to be widely usable, you should invent
> better name than sys_reiser4 :-).

Like ActiveFSControll or such? ;-)

- Gábor (larta'H)
