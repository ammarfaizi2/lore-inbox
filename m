Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278197AbRJRXFW>; Thu, 18 Oct 2001 19:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278205AbRJRXFM>; Thu, 18 Oct 2001 19:05:12 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:13074 "EHLO
	bodnar42") by vger.kernel.org with ESMTP id <S278197AbRJRXE5>;
	Thu, 18 Oct 2001 19:04:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Patch and Performance of larger pipes
Date: Thu, 18 Oct 2001 16:05:11 -0700
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3BCF1A74.AE96F241@colorfullife.com>
In-Reply-To: <3BCF1A74.AE96F241@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15uME1-0000Ht-00@bodnar42>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 18, 2001 11:07, Manfred Spraul wrote:
> Could you test the attached singlecopy patches?
>
> with bw_pipe,
> * on UP, up to +100%.

Awesome! Although any improvement improvement in efficiency is a good thing, 
I am curious as to what uses pipes besides gcc -pipe. UNIX domain sockets 
(for local X11, for instance) aren't implemented as pipes, are they? What 
sort of real world performance gains could I expect from this patch?

-Ryan
