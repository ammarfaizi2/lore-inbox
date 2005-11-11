Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVKKEVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVKKEVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 23:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVKKEVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 23:21:55 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:48551
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932333AbVKKEVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 23:21:54 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] fix ifenslave to not fail on lack of IP information
Date: Thu, 10 Nov 2005 22:20:59 -0600
User-Agent: KMail/1.8
Cc: Neil Horman <nhorman@tuxdriver.com>, linux-kernel@vger.kernel.org,
       bonding-devel@lists.sourceforge.net, ctindel@users.sourceforge.net,
       fubar@us.ibm.com, akpm@osdl.org
References: <20051104165434.GB17181@hmsreliant.homelinux.net> <20051107062325.GE11266@alpha.home.local>
In-Reply-To: <20051107062325.GE11266@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511102220.59852.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 November 2005 00:23, Willy Tarreau wrote:
> I find it annoying that ifenslave is still hosted by the kernel. I made
> this mistake years ago because it was not hosted anywhere and I needed
> to make changes available somewhere, but it should move to somewhere
> else, either as a standalone package on sf.net, or added to an existing
> package such as ifconfig, or better merged with it. I even think that
> if ifconfig included all ifenslave, vconfig, ethtool and brctl functions,
> it wouldn't be abandonned as it is now, but this is another problem.

We're adding it to busybox in the not-to-distant future.  (Possibly even Next 
Sunday, A.D.)

> Regards,
> Willy

Rob
