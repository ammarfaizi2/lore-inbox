Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWCVD4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWCVD4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWCVD4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:56:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:29601 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750725AbWCVD4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:56:12 -0500
Date: Wed, 22 Mar 2006 03:56:04 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, ccaputo@alt.net, dax@gurulabs.com,
       linux-kernel@vger.kernel.org, erich@areca.com.tw
Subject: Re: New Areca driver in 2.6.16-rc6-mm2
Message-ID: <20060322035604.GK27946@ftp.linux.org.uk>
References: <20060318044056.350a2931.akpm@osdl.org> <Pine.LNX.4.64.0603192016110.32337@mooru.gurulabs.com> <Pine.LNX.4.64.0603212345460.20655@nacho.alt.net> <20060322033718.GA21614@mea-ext.zmailer.org> <20060321195626.80d3fc02.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321195626.80d3fc02.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 07:56:26PM -0800, Randy.Dunlap wrote:
> On Wed, 22 Mar 2006 05:37:18 +0200 Matti Aarnio wrote:
> 
> 
> > 
> > I was apalled to learn that full cycle kernel compilation takes
> > _hours_ these days (Pentium-4 HT, 2.4 GHz, 2 GB memory -- and it
> > is about as slow as my first kernel compilation experience with
> > a 386/33MHz way back in ...)
> 
> You mean allmodconfig or allyesconfig, right?
> Yes, it does take a  l o n g  time.

Kill CONFIG_DEBUG_INFO and it'll go much faster...
