Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWI3KmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWI3KmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWI3KmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:42:06 -0400
Received: from mail5.postech.ac.kr ([141.223.1.113]:654 "EHLO
	mail5.postech.ac.kr") by vger.kernel.org with ESMTP
	id S1750803AbWI3KmD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:42:03 -0400
Date: Sat, 30 Sep 2006 19:42:05 +0900
From: Seongsu Lee <senux@senux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: specifying the order of calling kernel functions (or modules)
Message-ID: <20060930104205.GB10248@pooky.senux.com>
References: <20060928101724.GA18635@pooky.senux.com> <200609281547.k8SFl3Au004978@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200609281547.k8SFl3Au004978@turing-police.cc.vt.edu>
X-TERRACE-SPAMMARK: NO       (SR:4.79)                     
  (by Terrace)                                                   
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 11:47:02AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 28 Sep 2006 19:17:24 +0900, Seongsu Lee said:
> > I am a beginner of kernel module programming. I want to
> > specify the order of calling functions that I registered
> > by EXPORT_SYMBOL(). (or modules)
> 
> What problem did you expect to solve by specifying the order?  Phrased
> differently, why does the order matter?

I am playing with mtdconcat in MTD (Memory Technology Device).

For example:
  mtdconcat must be called after initializing the lower device and
  partitions. So, the order of calling functions must be decided
  always.

Actuall, the functions in Linux kernel are called in a order. I want
to know how to specify these orders.

Sorry for short English. Thank you for your help.

-- 
Seongsu Lee - http://www.senux.com/
"I don't think so," said Ren'e Descartes. Just then,
he vanished.




