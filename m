Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264309AbUD0TRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbUD0TRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbUD0TRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:17:44 -0400
Received: from spc1-brig1-3-0-cust85.lond.broadband.ntl.com ([80.0.159.85]:22407
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S264309AbUD0TRm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:17:42 -0400
Date: Tue, 27 Apr 2004 20:17:41 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE throughput in 2.6 - it's good!
In-Reply-To: <408E7E79.9080405@techsource.com>
Message-ID: <Pine.LNX.4.58.0404272016000.1170@ppg_penguin>
References: <Pine.LNX.4.58.0404232237140.19797@ppg_penguin>
 <408E7E79.9080405@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Timothy Miller wrote:

>
>
> Ken Moffat wrote:
>
> >
> > So, despite the numbers shown by hdparm looking worse, when only one
> > user is doing anything the performance is actually improved.  I've no
> > idea which changes have achieved this, but thanks to whoever were
> > involved.
>
>
> I've done tests using dd to and from the raw block device under 2.4 and
> 2.6.  Memory size (kernel boot param mem=) doesn't seem to affect
> performance, so I assume that means that dd to and from the raw block
> device is unbuffered.  When I compare read and write speeds between 2.4
> and 2.6, 2.6 is definately slower.  The last 2.6 kernel I tried this
> with is 2.6.5.
>

 Well, my original test used cp, sync, rm, sync.  I've no statistics
from running 2.4 on this box to compare against.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

