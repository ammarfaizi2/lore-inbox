Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317875AbSGZRh0>; Fri, 26 Jul 2002 13:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317878AbSGZRh0>; Fri, 26 Jul 2002 13:37:26 -0400
Received: from zok.SGI.COM ([204.94.215.101]:55712 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317875AbSGZRhZ>;
	Fri, 26 Jul 2002 13:37:25 -0400
Date: Fri, 26 Jul 2002 10:40:39 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: martin@dalecki.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.28
Message-ID: <20020726174039.GB793866@sgi.com>
Mail-Followup-To: martin@dalecki.de, linux-kernel@vger.kernel.org
References: <20020725233047.GA782991@sgi.com> <3D40DA00.9080603@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D40DA00.9080603@evision.ag>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 07:11:28AM +0200, Marcin Dalecki wrote:
> Well one one place? Every single implementation of the request_fn
> method from the request_queue_t needs to hold some
> lock associated with the queue in question.
> 
> In fact you will find ASSERT_LOCK macros sparnkled through the scsi code 
> already right now. BTW> ASSERT_HOLDS would sound a bit more
> familiar to some of us.
> 
> This minor issue asside I think that your idea is a good thing.

Thanks for the pointer.  I'll change those assertions over in the
next revision.

Jesse
