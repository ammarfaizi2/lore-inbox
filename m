Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVERFGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVERFGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 01:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVERFGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 01:06:49 -0400
Received: from dvhart.com ([64.146.134.43]:25506 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262091AbVERFGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 01:06:47 -0400
Date: Tue, 17 May 2005 22:06:52 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 boot failure
Message-ID: <323510000.1116392812@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.62.0505171806430.12337@schroedinger.engr.sgi.com>
References: <735450000.1116277481@flay> <20050516142504.696b443b.akpm@osdl.org><743780000.1116279381@flay> <919250000.1116372164@flay> <Pine.LNX.4.62.0505171806430.12337@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Christoph Lameter <clameter@engr.sgi.com> wrote (on Tuesday, May 17, 2005 18:07:16 -0700):

> On Tue, 17 May 2005, Martin J. Bligh wrote:
> 
>> > OK, fair enough. Christoph, I am interested in seeing your patch work 
>> > ... is something that's needed. If you want, I can help you offline 
>> > with some testing on a variety of platforms.
>> 
>> OK, I backed out the slab patches from -mm2, and confirmed the problem 
>> went away.
> 
> Is there any way I can access the system to figure out what is wrong? The 
> failure is in the page allocator and it seems that a node id is wrong.

Not really - IBM doesn't tend to like letting outside parties into their
network ;-) I think OSDL might have some power boxes now ... maybe it
fails on there?

M.

