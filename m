Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311312AbSCLSdT>; Tue, 12 Mar 2002 13:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311313AbSCLSdA>; Tue, 12 Mar 2002 13:33:00 -0500
Received: from pcp01314487pcs.hatisb01.ms.comcast.net ([68.63.220.2]:26515
	"EHLO bacchus.jdhouse.org") by vger.kernel.org with ESMTP
	id <S311312AbSCLSc5>; Tue, 12 Mar 2002 13:32:57 -0500
Date: Tue, 12 Mar 2002 12:34:51 -0600 (CST)
From: "Jonathan A. Davis" <davis@jdhouse.org>
To: walter <walt@nea-fast.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oracle rmap kernel version
In-Reply-To: <177640000.1015956385@flay>
Message-ID: <Pine.LNX.4.44.0203121229360.19382-100000@bacchus.jdhouse.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Martin J. Bligh wrote:

> > Does anyone have any production experience running Oracle 8i on Linux? I've 
> > run it at home, RH 7.2 with vanilla 2.4.16 kernel all IDE drives, and its 
> > fast. We are replacing our SUN/Oracle 8 servers at work in next couple of 
> 
> The real answer is to try them and do a benchmark for your particular
> application. Shouldn't take that long .... try the -aa tree too.
> 

I can't speak for -aa, but I can say definitively, DO NOT stay with the
"stock" kernel for oracle applications.  We're using -rmap here (mostly 9i
with some 8 scattered around) and performance under moderate and heavy
load is an order of magnitude better.

-- 

-Jonathan <davis@jdhouse.org>

