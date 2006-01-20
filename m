Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWATW6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWATW6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWATW6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:58:23 -0500
Received: from gate.in-addr.de ([212.8.193.158]:43916 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932284AbWATW6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:58:22 -0500
Date: Fri, 20 Jan 2006 23:57:24 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Heinz Mauelshagen <mauelshagen@redhat.com>, Neil Brown <neilb@suse.de>
Cc: Phillip Susi <psusi@cfl.rr.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060120225724.GW22163@marowsky-bree.de>
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060120183621.GA2799@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-20T19:36:21, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:

> > Then 'dmraid' (or a similar tool) can use 'dm' interfaces for some
> > raid levels and 'md' interfaces for others.
> Yes, that's possible but there's recommendations to have a native target
> for dm to do RAID5, so I started to implement it.

Can you answer me what the recommendations are based on?

I understand wanting to manage both via the same framework, but
duplicating the code is just ... wrong.

What's gained by it? Why not provide a dm-md wrapper which could then
load/interface to all md personalities?


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

