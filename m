Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVDBVGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVDBVGI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDBVGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:06:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:24735 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261284AbVDBVFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:05:02 -0500
Date: Sat, 2 Apr 2005 23:07:19 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: |TEcHNO| <techno@punkt.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SCSI] Driver broken in 2.6.x? 
In-Reply-To: <424EB65A.8010600@punkt.pl>
Message-ID: <Pine.LNX.4.62.0504022301430.2525@dragon.hyggekrogen.localhost>
References: <424EB65A.8010600@punkt.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2005, |TEcHNO| wrote:

> Hi,
> 
> I've recently switched form 2.4.x kernel series to 2.6.x, and I've encourted a
> problem with my old scanner card, 

> Apr  1 17:29:41 techno kernel: Modules linked in: nvidia

^^^ Very first thing to do is try it without the nvidia module loaded and 
then reproduce the problem and post the same info from your logs again.
As long as the nvidia module is loaded most people will disregard the 
bugreport since the source for the module is not available so if it has 
anything to do with the problem at all it is more or less un-debugable. If 
the problem can be reproduced without the nvidia module loaded then the 
info is more useful.

-- 
Jesper Juhl


