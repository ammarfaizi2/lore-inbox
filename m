Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVJKMgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVJKMgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 08:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVJKMgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 08:36:18 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14492 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932082AbVJKMgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 08:36:17 -0400
Subject: Re: [PATCH 2.6.14-rc2-mm2] core remove PageReserved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <434B7F19.5040808@yahoo.com.au>
References: <434B7F19.5040808@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Oct 2005 14:04:43 +0100
Message-Id: <1129035883.23677.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-10-11 at 19:00 +1000, Nick Piggin wrote:
> A last caveat: the ZERO_PAGE is now refcounted and managed with rmap
> (and thus mapcounted and count towards shared rss).

32000 processes each with 2G mapped as zero pages appears to allow the
refcount to overflow ?

Alan

