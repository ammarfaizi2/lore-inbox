Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTDOSY6 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTDOSY6 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:24:58 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:54716 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S262694AbTDOSY5 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:24:57 -0400
Date: Tue, 15 Apr 2003 14:33:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUGed to death
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304151436_MC3-1-3487-2163@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you do that, you must audit every single BUG_ON to make sure the
> expression doesn't have any side effects.
>
>	BUG_ON(do_the_good_stuff());


  Sounds like a candidate for machine audit.  You can declare
pure functions in GCC 2.96+ but I see no way to assert that an
expression is pure...



--
 Chuck
