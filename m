Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317906AbSGKUki>; Thu, 11 Jul 2002 16:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSGKUkf>; Thu, 11 Jul 2002 16:40:35 -0400
Received: from dsl-213-023-020-056.arcor-ip.net ([213.23.20.56]:36014 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317906AbSGKUkd>;
	Thu, 11 Jul 2002 16:40:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Douglas Gilbert <dougg@torque.net>
Subject: Re: direct-to-BIO for O_DIRECT
Date: Thu, 11 Jul 2002 22:43:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       linux-kernel@vger.kernel.org
References: <3D2A5F34.F38B893F@torque.net> <3D2A6608.7C43EE3@zip.com.au>
In-Reply-To: <3D2A6608.7C43EE3@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SkmH-0002Vu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 July 2002 06:26, Andrew Morton wrote:
> Ben had lightweight sg structures called `kvecs' and `kveclets'. And
> library functions to map pages into them.  And code to attach them
> to BIOs.  So we'll be looking at getting that happening.

And as I recall, a grand plan was hatched at the kernel summit to
slice and dice all the various forms of block IO into that model.

Seeing -> believing

-- 
Daniel
