Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTH3KDS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 06:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTH3KDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 06:03:18 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:41996 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263478AbTH3KDR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 06:03:17 -0400
Date: Sat, 30 Aug 2003 11:56:25 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Message-ID: <20030830095625.GN734@alpha.home.local>
References: <20030828223511.GA23528@werewolf.able.es> <20030829152418.GB709@wind.cocodriloo.com> <20030829184847.GA2069@werewolf.able.es> <Pine.LNX.4.53.0308291517001.32044@chaos> <20030830062744.GE640@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830062744.GE640@wind.cocodriloo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 08:27:44AM +0200, Antonio Vargas wrote:
 
> That was my fault for introducing an exchange instruction
> into an assignement discussion, but I don't know of any
> x86 instruction which can load 64bits to memory atomically,
> is there any???

perhaps "pusha", but it will load fare more than you need, and I don't know
if it's lockable.

Some MMX instruction might do it too, although not sure.

Willy

