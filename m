Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265381AbRFVLv4>; Fri, 22 Jun 2001 07:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbRFVLvq>; Fri, 22 Jun 2001 07:51:46 -0400
Received: from www.wen-online.de ([212.223.88.39]:60681 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S265381AbRFVLvi>;
	Fri, 22 Jun 2001 07:51:38 -0400
Date: Fri, 22 Jun 2001 13:50:43 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <Pine.LNX.4.21.0106220655450.933-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106221336150.319-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001, Marcelo Tosatti wrote:

> On Fri, 22 Jun 2001, Mike Galbraith wrote:
>
> > One thing that _could_ be done about looping allocations is to steal
> > a page from the clean list ignoring PageReferenced (if you have any).
> > That would be a very expensive 'rob Peter to pay Paul' trade though.
>
> Don't like it.

(I like it only slightly better than using cpu to heat air;)

Oh well.  Someone will think up the right answer eventually.

	-Mike

