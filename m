Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284898AbRLFA1V>; Wed, 5 Dec 2001 19:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284892AbRLFA0L>; Wed, 5 Dec 2001 19:26:11 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:63952 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284902AbRLFAZt>; Wed, 5 Dec 2001 19:25:49 -0500
Date: Wed, 05 Dec 2001 16:24:13 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rob Landley <landley@trommello.org>, Larry McVoy <lm@bitmover.com>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <2547106374.1007569453@mbligh.des.sequent.com>
In-Reply-To: <20011206001537.OPTF485.femail3.sdc1.sfba.home.com@there>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen people trying to do spinlocks across a numa system.  Why?  Don't Do 

Because they work well enough for low-contention locks. We have numa
aware locks too. Or just make the resource node-local.

M.

