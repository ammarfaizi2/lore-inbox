Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSFFRx4>; Thu, 6 Jun 2002 13:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSFFRxz>; Thu, 6 Jun 2002 13:53:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31218 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317035AbSFFRxy>; Thu, 6 Jun 2002 13:53:54 -0400
Subject: Re: [patch] CONFIG_NR_CPUS
From: Robert Love <rml@tech9.net>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020606170935.GA32506@www.kroptech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 10:52:42 -0700
Message-Id: <1023385962.13771.7.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 10:09, Adam Kropelin wrote:

> This isn't quite true now...

Ah, but it is on i386 which is what that configure entry is... since
this is in architecture-specific configure options, each arch must
maintain its only Config.help and Configure.in code.

Arches with 64-bit longs can s/32/64/ there..

	Robert Love

