Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUCPULK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUCPULK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:11:10 -0500
Received: from 64.221.211.203.ptr.us.xo.net ([64.221.211.203]:61345 "EHLO
	mail.pathscale.com") by vger.kernel.org with ESMTP id S261604AbUCPULG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:11:06 -0500
Subject: Re: [PATCH] klibc update
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg Kroah-Hartman <greg@kroah.com>,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-raid@vger.kernel.org
In-Reply-To: <20040316115340.361f2a14.akpm@osdl.org>
References: <4056B0DB.9020008@pobox.com>
	 <20040316005229.53e08c0c.akpm@osdl.org> <20040316153719.GA13723@kroah.com>
	 <20040316111026.6729e153.akpm@osdl.org> <40575279.7040408@pobox.com>
	 <20040316192458.GB21172@kroah.com> <40575631.1080006@pobox.com>
	 <20040316115340.361f2a14.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079467865.14516.56.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 12:11:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 11:53, Andrew Morton wrote:

> It would be rather handy if someone could maintain the definitive tree for
> this work for a while, until we linusify it.

I'll spend a bit of time in the next few days bringing it up to date
w.r.t the current kernel and klibc trees.

> I don't have a feeling for its stability/readiness/desirability/anthingelse
> at this stage.  How mergeable is it?

Not very.  klibc itself works OK, and the in-tree tools that use it work
OK, but they get very few "pick ourselves up off the ground and do a
complete boot" test cycles.

It's definitely 2.7 material.

	<b

