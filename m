Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTGGT4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTGGT4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:56:45 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:25781 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264398AbTGGT4o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:56:44 -0400
Subject: Re: Linux 2.4.22-pre3
From: Chris Mason <mason@suse.com>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200307071934.h67JYxdk003733@lt.wsisiz.edu.pl>
References: <200307071934.h67JYxdk003733@lt.wsisiz.edu.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1057608615.20903.1361.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Jul 2003 16:10:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-07 at 15:34, Lukasz Trabinski wrote:
> In article <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> you wrote:
> > 
> > Hi,
> > 
> > Here goes -pre3. It contains a lot of updates and fixes all over.
> > 
> > We should have increased interactivity under heavy IO (users with
> > interactivity problems please test and report results).
> 
> Well, I have still big load (80-120) when slocate running on my big ext3 HOME
> area ( 12x23GB partitions ). If You need, I can send to you snapshots from
> SysRq.

The changes in -pre3 won't cut down on the load reported by top/ps.  The
goal is to cut down on latencies on the box as a whole.  So the load
will still be as high, but you'll still be able to do an ls without
waiting indefinitely for the results.

So, if you are still seeing bad response times, I can send you a patch
to try in private mail (it has been posted here a few times already).

-chris


