Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318708AbSHWIWW>; Fri, 23 Aug 2002 04:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318709AbSHWIWW>; Fri, 23 Aug 2002 04:22:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5366 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318708AbSHWIWV>; Fri, 23 Aug 2002 04:22:21 -0400
Subject: Re: Hyperthreading
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gilad Ben-Yossef <gilad@benyossef.com>,
       James Bourne <jbourne@mtroyal.ab.ca>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208230852320.9367-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208230852320.9367-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 09:27:48 +0100
Message-Id: <1030091268.5932.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 09:10, Hugh Dickins wrote
> The mainline 2.4 does not take that into consideration, and so far
> as I can see (please correct me), nor does 2.5 as yet - will probably
> get added from 2.4 -aa or -ac in due course.  It's not an issue of
> correctness, just optimality.

Its disabled in -ac too. The scheduling balance patches were causing
crashes

