Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSHHQXn>; Thu, 8 Aug 2002 12:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSHHQXm>; Thu, 8 Aug 2002 12:23:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1263 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317636AbSHHQXm>; Thu, 8 Aug 2002 12:23:42 -0400
Subject: Re: problems with 1gb ddr memory sticks on linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bryan K. Walton" <thisisnotmyid@tds.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020808160456.GI16225@weccusa.org>
References: <20020808160456.GI16225@weccusa.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 18:47:20 +0100
Message-Id: <1028828840.28883.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 17:04, Bryan K. Walton wrote:
> 1) The box runs FAST with M$ Windows 2000.
> 2) The box runs FAST when using identical kinds of memory but in
> quantities of 512MB or less.
> 3) The box runs slow with other linux distos also. (I tried Redhat 7.2)
> 
> It seems to me that the problem has something to do with the linux
> kernel and 1GB memory sticks.  Am I off base?

Almost certainly a BIOS problem. What typically happens when you see
this is that the BIOS misconfigured the MTRR registers. Linux starts
from top of ram windows seems to start from bottom so the effect shows
strongly in Linux.

Can you post your /proc/mtrr file please

