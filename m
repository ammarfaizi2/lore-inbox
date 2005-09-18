Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVIRXLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVIRXLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 19:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVIRXLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 19:11:31 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:21691 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932261AbVIRXLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 19:11:30 -0400
Date: Mon, 19 Sep 2005 01:08:22 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: workaround large MTU and N-order allocation failures
Message-ID: <20050918230822.GA5440@electric-eye.fr.zoreil.com>
References: <20050918143526.GA24181@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918143526.GA24181@localdomain>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni <da-x@monatomic.org> :
[...]
> The problem with large MTU is external memory fragmentation in
> the buddy system following high workload, causing alloc_skb() to 
> fail.

If the issue hits the Rx path, it is probably the responsibility of
the device driver. Which kind of hardware do you use ?

--
Ueimor
