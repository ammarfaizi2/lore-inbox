Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSGYVPL>; Thu, 25 Jul 2002 17:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSGYVPK>; Thu, 25 Jul 2002 17:15:10 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58865 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316491AbSGYVPK>; Thu, 25 Jul 2002 17:15:10 -0400
Subject: Re: [PATCH] VM accounting 1/3 trivial
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Robert Love <rml@tech9.net>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0207252037160.1669-100000@localhost.localdomain>
References: <Pine.LNX.4.21.0207252037160.1669-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 23:31:49 +0100
Message-Id: <1027636309.11568.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 21:31, Hugh Dickins wrote:
> You have no protection against the earlier NORESERVEs, and I'm unclear
> whether or not you want that additional protection: it's a little like
> "Tainted", you won't want people raising bugs against no-overcommit when

There are two things I want to fix there - one is to account noreserve
but not fail it, the other is to allow a root reservation

As to the other tests I'd rather get it merged, test it hard in a real
2.5 release and then go over and fix the other stuff and add features

