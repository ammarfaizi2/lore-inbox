Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319327AbSIEXRI>; Thu, 5 Sep 2002 19:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319329AbSIEXRI>; Thu, 5 Sep 2002 19:17:08 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:53232
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319327AbSIEXRH>; Thu, 5 Sep 2002 19:17:07 -0400
Subject: Re: 2.4.20pre5 trivial compiler warning fix for nmclan_cs.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D77C2D2.5090607@domdv.de>
References: <3D77C2D2.5090607@domdv.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 00:22:53 +0100
Message-Id: <1031268173.7405.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 21:47, Andreas Steinmetz wrote:
> the attached patch disables dead code in nmclan_cs.c and thus fixes a 
> compiler warning.

Ethtool is stuff getting added. Actually hooking it in is probably the
right thing to do now the ethtool core stuff is in

