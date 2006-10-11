Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWJKSpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWJKSpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWJKSpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:45:50 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5323 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965224AbWJKSpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:45:49 -0400
Message-ID: <452D3BB6.8040200@zytor.com>
Date: Wed, 11 Oct 2006 11:45:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use %p for pointers
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk> <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr> <20061011145441.GB29920@ftp.linux.org.uk>
In-Reply-To: <20061011145441.GB29920@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> 
> %p will do no such thing in the kernel.  As for the difference...  %x
> might happen to work on some architectures (where sizeof(void *)==sizeof(int)),
> but it's not portable _and_ not right.  %p is proper C for that...

It's really too bad gcc bitches about %#p, because that's arguably The 
Right Thing.

	-hpa
