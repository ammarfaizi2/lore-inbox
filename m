Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbTALURn>; Sun, 12 Jan 2003 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTALURn>; Sun, 12 Jan 2003 15:17:43 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:57485 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267495AbTALURn>; Sun, 12 Jan 2003 15:17:43 -0500
Date: Sun, 12 Jan 2003 21:26:31 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112202631.GC7132@louise.pinerecords.com>
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com> <1042401596.1209.51.camel@RobsPC.RobertWilkens.com> <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Valdis.Kletnieks@vt.edu]
> 
> The real problem is that C doesn't have a good multi-level "break" construct.
> On the other hand, I don't know of any language that has a good one - some
> allow "break 3;" to break 3 levels- but that's still bad because you get
> screwed if somebody adds an 'if' clause....

Not necessarily.  A good multilevel break/continue implementation will
only work on loop blocks, not conditionals.

-- 
Tomas Szepe <szepe@pinerecords.com>
