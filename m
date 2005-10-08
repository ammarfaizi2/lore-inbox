Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVJHQIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVJHQIq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 12:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVJHQIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 12:08:46 -0400
Received: from mxsf33.cluster1.charter.net ([209.225.28.158]:18060 "EHLO
	mxsf33.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932133AbVJHQIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 12:08:46 -0400
X-IronPort-AV: i="3.97,189,1125892800"; 
   d="scan'208"; a="1498987317:sNHT14467902"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17223.61190.917668.850611@smtp.charter.net>
Date: Sat, 8 Oct 2005 12:08:38 -0400
From: "John Stoffel" <john@stoffel.org>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org, Molle Bestefich <molle.bestefich@gmail.com>,
       htejun@gmail.com, linux-raid@vger.kernel.org
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
In-Reply-To: <200510081555.41159.andrew@walrond.org>
References: <200510071111.46788.andrew@walrond.org>
	<43477836.6020107@gmail.com>
	<62b0912f0510080726ge2436e9ra6d7e8d17d1001ee@mail.gmail.com>
	<200510081555.41159.andrew@walrond.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Walrond <andrew@walrond.org> writes:

Andrew> Likewise. I've been using exclusively SATA with linux raid for
Andrew> quite a while now, with great success. But for the super
Andrew> resilient zero downtime servers I now need to deploy, I must
Andrew> be able to swap dead drives without taking the server
Andrew> down. Hence my query.

Andrew> Off-list respondants have recommended 3ware hardware raid
Andrew> products, but throughput concerns on another thread here have
Andrew> really put me off that idea.

Hmm... I've been watching those 3ware discussions with interest as
well, but I haven't seen any commments on how well they work as JBOD
controllers, esp if you get smaller ones with fewer channels and
stripe/mirror between controllers.  If you pair disks between
controllers, then that should limit the downtime, and also improve
performance.

I've been thinking that getting a pair of the two or four change old
74xx series 3ware controllers and then striping across RAID pairs done
between controllers.

John
