Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752098AbWAEL6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbWAEL6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbWAEL6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:58:33 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:35514 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752098AbWAEL6c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:58:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TM1/adDffTlogMXyNDH4kquqQTW/PJaMUWm7CGKQFHopTc1NowguXNhozxRkcyRLulbxME5CPYoibxLwsV89wi0981I5IUJB/O7XMS8f7a8o0ilZ1jDtfZ9Srj2OIePbOtcf/2v7htf9Npvjlo8d5AaYRTNPMypPQJG6IXprBMU=
Message-ID: <df33fe7c0601050357o1b699a4aw@mail.gmail.com>
Date: Thu, 5 Jan 2006 12:57:57 +0100
From: Takis <panagiotis.issaris@gmail.com>
Reply-To: takis@issaris.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] cs53l32a: kzalloc conversion
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060104163929.58a083d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103143301.0D98E5BC3@localhost.localdomain>
	 <20060104163929.58a083d8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2006/1/5, Andrew Morton <akpm@osdl.org>:
> >  drivers/media/video/cs53l32a.c |    3 +--
> >  1 files changed, 1 insertions(+), 2 deletions(-)
> A quick grep shows that there are ~60 kmalloc+memsets under
> drivers/media/video.  So I'd prefer that if we're going to do this, we do
> it all in one big hit rather than merging a dribble of little patches.
Sure, prepared two patches yesterday night doing the drivers/media and
net/ directories. I've sent the drivers/media patch earlier today and
will review and submit the net/ patch this evening.

With friendly regards,
Takis
