Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTKLDp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTKLDp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:45:27 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:3599
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261484AbTKLDpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:45:24 -0500
Date: Tue, 11 Nov 2003 19:45:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Daniel Drake <dan@reactivated.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm2
Message-ID: <20031112034525.GI2014@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	Daniel Drake <dan@reactivated.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031104225544.0773904f.akpm@osdl.org> <3FB11B93.60701@reactivated.net> <3FB18A69.6020104@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB18A69.6020104@cyberone.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 12:18:33PM +1100, Nick Piggin wrote:
> Switching from X to console or back can cause high CPU scheduling
> latencies. I haven't tried to discover why.

I've heard that it's because of the locking in the tty layer.
