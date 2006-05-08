Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWEHR5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWEHR5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWEHR5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:57:44 -0400
Received: from mail3.hsn.net ([161.254.6.45]:29192 "EHLO stpete.hsn.net")
	by vger.kernel.org with ESMTP id S932503AbWEHR5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:57:44 -0400
Subject: Re: [dm-crypt] dm-crypt is broken and causes massive data
	corruption
From: "Simpson, Brett" <bart@hsn.net>
Reply-To: bart@hsn.net
To: dm-crypt@saout.de
Cc: linux-kernel@vger.kernel.org,
       Tillmann Steinbrecher <tsteinbr@igd.fraunhofer.de>
In-Reply-To: <445F7DCC.2000508@igd.fraunhofer.de>
References: <445F7DCC.2000508@igd.fraunhofer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: HSN
Date: Mon, 08 May 2006 13:57:29 -0400
Message-Id: <1147111049.31050.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 19:20 +0200, Tillmann Steinbrecher wrote:

> it's been many months that dm-crypt has been broken, and is known to 
> cause massive data corruption.
> 
> Various people have noticed this, have lost data and wasted many hours 
> trying to find the reason, and still NOTHING is being done about it. The 
> problem seems to occur only in conjunction with RAID (dm-crypt on top of 
> RAID) (or possibly it occurs only in conjunction with large 
> filesystems). I've had issues with that for many months as well, trying 
> to eliminate other possible reasons. There are none.

I've been running Gentoo for over month with a 54GB ext3 filesystem via
dm-crypt on an IDE drive. No problems so far.

I've used Gentoo-sources 2.6.16-r1 and vanilla kernels 2.6.17-rc1
through rc3.

I've been using cryptsetup-1.0.1-i686-pc-linux-gnu-static and have it in
my initrd so I can mount my root partition.

Brett
