Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVDBVsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVDBVsu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVDBVhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:37:02 -0500
Received: from mail.dif.dk ([193.138.115.101]:55199 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261380AbVDBVWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:22:31 -0500
Date: Sat, 2 Apr 2005 23:24:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: |TEcHNO| <techno@punkt.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SCSI] Driver broken in 2.6.x?
In-Reply-To: <424F0BFF.6020402@punkt.pl>
Message-ID: <Pine.LNX.4.62.0504022322150.2525@dragon.hyggekrogen.localhost>
References: <424EB65A.8010600@punkt.pl> <Pine.LNX.4.62.0504022301430.2525@dragon.hyggekrogen.localhost>
 <424F0BFF.6020402@punkt.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2005, |TEcHNO| wrote:

> Hi,
> 
> <cut, nVidia module tainting>
> First of all, I don't have my X configured to work w/o that module, and I
> don't think I can do it now.

You should be able to just use the "nv" driver instead of the "nvidia" 
driver - that should be the only change you need to make in xorg.conf ...


> Second of all, the 2.4.x kernel had this module too, and worked flawlessly.
> 
It's probably unrelated to the problem, but being able to reproduce it 
without that module will make more people take the bugreport seriously and 
it will also eliminate the nvidia module as a potential cause...


-- 
Jesper Juhl


