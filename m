Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbTEDQ4S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTEDQ4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 12:56:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8609
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261171AbTEDQ4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 12:56:16 -0400
Subject: Re: comparision between signed and unsigned
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052040732.25950.4.camel@marx>
References: <1052040732.25950.4.camel@marx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052064610.1242.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2003 17:10:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-04 at 10:32, Anders Karlsson wrote:
> Hi list,
> 
> Sitting here watching the compile output from 2.4.21-rc1-ac4 and
> noticing there is a _lot_ of warnings about comparisions between signed
> and unsigned values. The question I have is the following. If all the
> signed values were modified to unsigned to fix the warnings, how likely
> are things to break? Is there any reason to use signed values unless a
> specific reason when negative values are required?

There has been some work done checking entries for errors in 2.4 and
fixing a few real errors. As to others, its mostly gcc being excessively
noisy by default.

If you want to work on them do it on 2.5 though

