Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTFEJIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTFEJIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:08:05 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:15798 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S264537AbTFEJID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:08:03 -0400
Date: Thu, 5 Jun 2003 11:21:29 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm4
In-Reply-To: <200306042333.26850.rudmer@legolas.dynup.net>
Message-ID: <Pine.LNX.4.51.0306051120250.17494@dns.toxicfilms.tv>
References: <20030603231827.0e635332.akpm@digeo.com>
 <200306042333.26850.rudmer@legolas.dynup.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got the following errors with every file that includes
> include/linux/bitops.h
>
> include/linux/bitops.h: In function `generic_hweight64':
> include/linux/bitops.h:118: warning: integer constant is too large for "long"
> type
> include/linux/bitops.h:118: warning: integer constant is too large for "long"
> type
> include/linux/bitops.h:119: warning: integer constant is too large for "long"
<snip>

Same here with debian unstable with gcc-3.3, it started to act like that
since -mm4, mm3 was ok.

> This is on UP, athlon, gcc 3.3
Also UP on P4.

Regards,
Maciej

