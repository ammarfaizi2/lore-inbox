Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbUCXSsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 13:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUCXSsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 13:48:47 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:38413 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S263067AbUCXSsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 13:48:46 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: missing files in bk trees?
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20040324043521.GA28169@thunk.org> (Theodore Ts'o's message of
 "Tue, 23 Mar 2004 23:35:22 -0500")
References: <Pine.LNX.4.58.0403232140160.7713@debian>
	<pan.2004.03.24.02.50.16.373654@triplehelix.org>
	<20040324043521.GA28169@thunk.org>
X-Hashcash: 0:040324:linux-kernel@vger.kernel.org:a799d7e30756f027
Date: Wed, 24 Mar 2004 03:48:54 -0500
Message-ID: <m3ptb2eikp.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Josh" == Joshua Kwan <joshk@triplehelix.org> writes:
>>>>> "Ted" == Theodore Ts'o <tytso@mit.edu> writes:

Josh> you need to do 'bk -r get' in the root of your checkout

Ted> Better to do a "bk -r get -S", actually.  That way files 
Ted> that are already checked out won't be created a second time.

And even better, add a -U to skip the deleted files and others
under the BitKeeper dir:

    bk -r -U get -S

-JimC

