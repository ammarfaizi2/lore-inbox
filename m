Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUHRGvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUHRGvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUHRGvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:51:39 -0400
Received: from mail5.dslextreme.com ([66.51.199.81]:50317 "HELO
	mail5.dslextreme.com") by vger.kernel.org with SMTP id S261232AbUHRGvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:51:37 -0400
Date: Tue, 17 Aug 2004 23:49:47 -0700 (PDT)
From: Richard A Nelson <cowboy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1{,-mm1} boot failure on Athlon/A7V600
In-Reply-To: <Pine.LNX.4.58.0408172155410.5882@hygvzn-guhyr.pnirva.bet>
Message-ID: <Pine.LNX.4.58.0408172346280.12101@hygvzn-guhyr.pnirva.bet>
References: <Pine.LNX.4.58.0408172155410.5882@hygvzn-guhyr.pnirva.bet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Interestingly enough - it is network related... If I unplug the e100
cable before booting, and let things come up before plugging it in
I'm set to go (thus far) !

I'm wondering if it might be related to:
	OOPS: 2.6.8.1 QoS and routing conflict (bug)

and by delaying the ifup, I've missed some of the problem.

I'll let it run as long as possible - at least now I should be able
to capture the oops should it bite me again.
-- 
Rick Nelson
Mere nonexistence is a feeble excuse for declaring a thing unseeable. You
*can* see dragons.  You just have to look in the right direction.
        -- John Hasler

