Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSJWUGr>; Wed, 23 Oct 2002 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265192AbSJWUGr>; Wed, 23 Oct 2002 16:06:47 -0400
Received: from DSL022.LABridge.com ([206.117.136.22]:10761 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id <S265190AbSJWUGq>;
	Wed, 23 Oct 2002 16:06:46 -0400
Subject: Re: [RFC] CONFIG_TINY
From: Joe Perches <joe@perches.com>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021023215117.A29134@jaquet.dk>
References: <20021023215117.A29134@jaquet.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 23 Oct 2002 13:11:58 -0400
Message-Id: <1035393119.10067.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 15:51, Rasmus Andersen wrote:
> o reduce usage of prinkt in kernel by #defining iprintk for
>   INFO messages etc and let the desired (minimum) logging 
>   level be decided at compile time.

kernel.h already has #defines for pr_debug and pr_info.
perhaps all 8 current KERN_xxx's could be pr_#define'd
and the printks converted during 2.7+

I think this should be done together with Larry Kessler's
kernel logging proposal.



