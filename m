Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292348AbSBPKQO>; Sat, 16 Feb 2002 05:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292347AbSBPKQF>; Sat, 16 Feb 2002 05:16:05 -0500
Received: from dsl-213-023-039-219.arcor-ip.net ([213.23.39.219]:50061 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292344AbSBPKPq>;
	Sat, 16 Feb 2002 05:15:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] queue barrier support
Date: Sat, 16 Feb 2002 11:20:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200202131826.g1DIQCT02506@localhost.localdomain>
In-Reply-To: <200202131826.g1DIQCT02506@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16c1xJ-0002qR-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 07:26 pm, James Bottomley wrote:
> A problem (that is probably only an issue for older drives) is that while 
> technically the standard requires all 3 types of TAG to be supported if tag 
> queueing is, some drives really only have simple tag support in their 
> firmware, so you may need to add a blacklist for ordered tags on certain 
> drives.

>From user space, I hope.

-- 
Daniel
