Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVF2Rlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVF2Rlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVF2RDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:03:44 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:29870 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262636AbVF2RCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:02:40 -0400
X-ORBL: [63.202.173.158]
Date: Wed, 29 Jun 2005 10:02:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Al Boldi <a1426z@gawab.com>
Cc: "'Nathan Scott'" <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
Message-ID: <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org>
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506290453.HAA14576@raad.intranet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 07:53:09AM +0300, Al Boldi wrote:

> What I found were 4 things in the dest dir:
> 1. Missing Dirs,Files. That's OK.
> 2. Files of size 0. That's acceptable.
> 3. Corrupted Files. That's unacceptable.
> 4. Corrupted Files with original fingerprint. That's ABSOLUTELY
> unacceptable.

disk usually default to caching these days and can lose data as a
result, disable that
