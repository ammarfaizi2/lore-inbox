Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269386AbUIYSkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269386AbUIYSkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269387AbUIYSkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:40:16 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:61460 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269386AbUIYSkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:40:05 -0400
Message-ID: <9e4733910409251140569fdd36@mail.gmail.com>
Date: Sat, 25 Sep 2004 14:40:00 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: __initcall macros and C token pasting
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104092510574c908525@mail.gmail.com>
	 <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for bothering you. I'm trying to work out a scheme for
transitioning most of the DRM() macros out of the DRM source without
breaking everything. Right now I can get rid of all but six uses.  I
was going to fix this one in the next pass and I needed a solution to
keep everything working for the moment. I was focused on the point of
the error and didn't think about fixing it at a higher level.

-- 
Jon Smirl
jonsmirl@gmail.com
