Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUGQP70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUGQP70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 11:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266713AbUGQP7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 11:59:25 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:21414 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266708AbUGQP7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 11:59:24 -0400
Date: Sat, 17 Jul 2004 17:57:17 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jean Francois Martinez <jfm512@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Davicom DM9102AF card working only at 10 Mbps
Message-ID: <20040717175717.A11275@electric-eye.fr.zoreil.com>
References: <1090070520.4498.25.camel@agnes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1090070520.4498.25.camel@agnes>; from jfm512@free.fr on Sat, Jul 17, 2004 at 03:22:00PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Francois Martinez <jfm512@free.fr> :
> I have an ethernet card with a DM9102AF chip.  It only works at 10 Mbps.
> 
> More precisely by using etheral on another box I see the frames it is
> sending but it seems unable to catch the replies.  If I configure it 
> to transmit at 10 Mbps then it works.

The name of the driver ('lsmod' output) would help identify the relevant
maintainer (if any). It seems to be a tulip clone, right ?

> It happens both with 2.4 and 2.6 kernels.

Some more details could help as well:
- vendor or vanilla kernel ?
- sub-revision ?
- latest -bk/-mm ?

--
Ueimor
