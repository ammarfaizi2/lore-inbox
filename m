Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUFKILw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUFKILw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUFKIKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:10:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61096 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263766AbUFKHzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 03:55:44 -0400
Date: Fri, 11 Jun 2004 09:55:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and later)
Message-ID: <20040611075515.GR13836@suse.de>
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C8A241.50608@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10 2004, Jeff Garzik wrote:
> Oh, also:
> 
> We'll need to write up precisely _why_ this is used, and give some 
> examples of usage, for people reading the proposal (mostly T13-ish 
> people) who have not been following the lkml barrier discussion closely.

Proposal looks fine, but please lets not forget that flush cache range
is really a band-aid because we don't have a proper ordered write in the
first place. Personally, I'd much rather see that implemented than flush
cache range. It would be way more effective.

-- 
Jens Axboe

