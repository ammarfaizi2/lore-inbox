Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVLTTjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVLTTjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVLTTjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:39:31 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:45527 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751034AbVLTTja convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:39:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KJZgQFK4VULjuEAFj5r+dOsw6LYldbSYHDWXYkZjmjol20dMcbQdkDjE8NZjM1eld/fEaKKLVM33nqASit4mTSI337Cto8Q9K8QBvYoiVLFI6pAOUixDYJMkwRrYbxmrBh2KMgLVRQnKYpyBZhhJ+yRr6tcjMQaEBNE4bYoZrDU=
Message-ID: <9268368b0512201139v1836c920iaa6bdc11bd8f4e15@mail.gmail.com>
Date: Tue, 20 Dec 2005 15:39:28 -0400
From: Daniel Petrini <d.pensator@gmail.com>
To: Jan De Luyck <lkml@kcore.org>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <200512201827.56387.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512210310.51084.kernel@kolivas.org>
	 <200512201827.56387.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 12/20/05, Jan De Luyck <lkml@kcore.org> wrote:
> On Tuesday 20 December 2005 17:10, Con Kolivas wrote:
> > Here is the latest version of the dynticks code incorporating a huge
> > rewrite correcting all the known problems with the previous code.
>
> Works nicely sofar. One slight bug in the pmstats code, the interval setting
> doesn't work because of a missing else clause.
>
> One thing I'm curious about (and haven't tested yet): does this also work with
> S3 suspend to ram? Last dynticks I tried had issues with that...

I'm testing suspend to ram and it is working normally with dyn-ticks. 
What kind of problems are you facing?


Daniel
