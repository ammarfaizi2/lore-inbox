Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUIBVAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUIBVAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIBU5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:57:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:13446 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269090AbUIBU5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:57:07 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Pavel Machek <pavel@ucw.cz>, Spam <spam@tnonline.net>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040902204949.GA7449@taniwha.stupidest.org>
References: <rlrevell@joe-job.com>
	 <1094079071.1343.25.camel@krustophenia.net>
	 <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
	 <1535878866.20040902214144@tnonline.net>
	 <20040902194909.GA8653@atrey.karlin.mff.cuni.cz>
	 <1094155277.11364.92.camel@krustophenia.net>
	 <20040902204351.GE8653@atrey.karlin.mff.cuni.cz>
	 <1094158060.1347.16.camel@krustophenia.net>
	 <20040902204949.GA7449@taniwha.stupidest.org>
Content-Type: text/plain
Message-Id: <1094158626.1347.28.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 16:57:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 16:49, Chris Wedgwood wrote:
> On Thu, Sep 02, 2004 at 04:47:40PM -0400, Lee Revell wrote:
> 
> > But how do you cache the information you had to look in the archive
> > for in a way that other apps can use it?
> 
> ~/.object-cache/ or whatever
> 

How are permissions handled?  If root lists the contents of a tar file
that is world readable, then joeuser comes along and does the same, can
joeuser sees the cached listing?  Would it depend on root's umask?

Lee

