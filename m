Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbVIHPiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbVIHPiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbVIHPiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:38:25 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:3355 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932706AbVIHPiX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:38:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iZH+GCKzS+o5Cdv+2rLtJ6ZRaHzsYJ3Lrko/f5z7AXKAjk6HQ3+kBiZKFuHAM1uHqtZb9EDCVhfFf4E3e7IVneYe0HEPaauBtidUbv1BwpD5TAxqNRHh1kqZQkp9vAghRE0w+0KJ3JPqe/yI6EE37rwLEuJskRMyZjb1gwlvm54=
Message-ID: <6bffcb0e050908083822616326@mail.gmail.com>
Date: Thu, 8 Sep 2005 17:38:22 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-git7 strange system freeze
Cc: netdev@vger.kernel.org, akpm@osdl.org
In-Reply-To: <6bffcb0e050908051412e945c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6bffcb0e050908051412e945c9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel: 2.6.13-mm2

it happens when I try to download new gnome-2.12 livecd from bittorrent.

ng02:/home/michal# tail /var/log/kern.log
[..]
Sep  8 17:15:39 ng02 kernel: [ 3241.479108] KERNEL: assertion
((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
Sep  8 17:15:39 ng02 kernel: [ 3241.479192] KERNEL: assertion
((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (1127)
Sep  8 17:15:39 ng02 kernel: [ 3241.479736] KERNEL: assertion
((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (1127)
Sep  8 17:15:39 ng02 kernel: [ 3241.831114] KERNEL: assertion
((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
Sep  8 17:15:40 ng02 kernel: [ 3242.103942] KERNEL: assertion
((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
Sep  8 17:15:40 ng02 kernel: [ 3242.103951] Leak l=4294967295 3

Regards,
Michal Piotrowski
