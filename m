Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268764AbUIBUxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268764AbUIBUxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUIBUwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:52:50 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:63179 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269126AbUIBUuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:50:21 -0400
Date: Thu, 2 Sep 2004 13:49:49 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@ucw.cz>, Spam <spam@tnonline.net>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902204949.GA7449@taniwha.stupidest.org>
References: <rlrevell@joe-job.com> <1094079071.1343.25.camel@krustophenia.net> <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl> <1535878866.20040902214144@tnonline.net> <20040902194909.GA8653@atrey.karlin.mff.cuni.cz> <1094155277.11364.92.camel@krustophenia.net> <20040902204351.GE8653@atrey.karlin.mff.cuni.cz> <1094158060.1347.16.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094158060.1347.16.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 04:47:40PM -0400, Lee Revell wrote:

> But how do you cache the information you had to look in the archive
> for in a way that other apps can use it?

~/.object-cache/ or whatever

> How do you synchronize access to the cache and maintain cache
> coherency in userspace?

coherency doesn't exist for normal files for the most part anyhow
