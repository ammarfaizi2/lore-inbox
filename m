Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTAOOW6>; Wed, 15 Jan 2003 09:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTAOOW6>; Wed, 15 Jan 2003 09:22:58 -0500
Received: from cnxt10002.conexant.com ([198.62.10.2]:65008 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S266638AbTAOOW4>; Wed, 15 Jan 2003 09:22:56 -0500
Date: Wed, 15 Jan 2003 15:31:44 +0100 (CET)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@sophia-sousar2.nice.mindspeed.com
To: Alistair Strachan <alistair@devzero.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] emu10k1 forward port (2.4.20 to 2.5.56)
In-Reply-To: <200301151340.39264.alistair@devzero.co.uk>
Message-ID: <Pine.LNX.4.44.0301151524510.1380-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Alistair Strachan wrote:

I'm still not sure if I agree with this change... Couldn't be possible
that even if one __copy_from_user() fails the next one could succeed?
Is it really necessary to return at the first error?

Rui

> Hi,
> 
> This diff applies over the top of Rui's diff to provide the 
> __copy_{to,from}_user fixes present in -dj. The merging of both these diffs 
> would remove all the remaining important emu10k1 changes from -dj.
> 
> Cheers,
> Alistair Strachan.
> 

