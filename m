Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVBPKVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVBPKVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 05:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVBPKVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 05:21:20 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:56803 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261989AbVBPKVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 05:21:16 -0500
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: kernel@crazytrain.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
References: <20050214020802.GA3047@bitmover.com>
	<58cb370e05021404081e53f458@mail.gmail.com>
	<20050214150820.GA21961@optonline.net>
	<20050214154015.GA8075@bitmover.com>
	<7579f7fb0502141017f5738d1@mail.gmail.com>
	<20050214185624.GA16029@bitmover.com>
	<1108469967.3862.21.camel@crazytrain> <42131637.2070801@tequila.co.jp>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 16 Feb 2005 10:21:36 +0000
In-Reply-To: <42131637.2070801@tequila.co.jp> (Clemens Schwaighofer's
 message of "Wed, 16 Feb 2005 18:45:27 +0900")
Message-ID: <tnx7jl824b3.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer <cs@tequila.co.jp> wrote:
> On 02/15/2005 09:19 PM, kernel wrote:
>> With all of the complaining about BK you'd think there'd be an equal
>> alternative.
>
> there is no need for that. There is already one. Subversion is a more
> than mature VCS. Apache group is switching to it, gcc people are
> strongly thinking about it, and those two are _huge_ projects with tons
> of developers, patches, trunks, etc.

Subversion and BK are quite different. The first one is snapshot
oriented and the latter is changeset oriented (I find this a more
powerful concept). Subversion is not distributed (you have some helper
scripts but I don't know how stable they are), which is somehow
mandatory for the way Linux is developed. Subversion also lacks any
smart merging capabilities (it doesn't even remember what was
merged).

GNU Arch is probably as close as you can get regarding features and
performance (I can't compare the two since I've never used BK).

Catalin

