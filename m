Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbUKINm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUKINm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 08:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUKINm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 08:42:56 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:64432 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S261294AbUKINmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 08:42:54 -0500
Subject: Re: [PATCH 2.6.9 0/2] new enhanced accounting data collection
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Reply-To: guillaume.thouvenin@bull.net
To: Jay Lan <jlan@engr.sgi.com>
Cc: lse-tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
In-Reply-To: <418FC082.8090706@engr.sgi.com>
References: <418FC082.8090706@engr.sgi.com>
Message-Id: <1100007698.18813.12.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 09 Nov 2004 14:41:38 +0100
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2004 14:48:28,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2004 14:48:34,
	Serialize complete at 09/11/2004 14:48:34
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 19:52, Jay Lan wrote:
> In earlier round of discussion, all partipants favored  a common
> layer of accounting data collection.
> 
> This is intended to offer common data collection method for various
> accounting packages including BSD accounting, ELSA, CSA, and any other
> acct packages that use a common layer of data collection.

I found this great. Now I think, as you already pointed, we need to
modify the end-of-process handling. Currently I use the BSD structure
but this part of ELSA can be changed very easily.

Regards, 
Guillaume 

