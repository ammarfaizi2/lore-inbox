Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUEXWgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUEXWgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUEXWgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:36:12 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:55818 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264206AbUEXWgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:36:04 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: your mail
Date: Tue, 25 May 2004 00:34:43 +0200
User-Agent: KMail/1.6.2
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
References: <67B3A7DA6591BE439001F2736233351202B47E6E@xch-nw-28.nw.nos.boeing.com> <20040524223022.GA29595@MAIL.13thfloor.at>
In-Reply-To: <20040524223022.GA29595@MAIL.13thfloor.at>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405250034.43127@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 May 2004 00:30, Herbert Poetzl wrote:

Hi Joseph,

> > Dynamically change the priorities of processes (up and down)
> > Lock processes in memory
> > Can change process cpu affinity
> > Anyone got any ideas about how I could start doing this?  (I'm new to
> > kernel development, btw.)
> check the kernel capability system ...
> (it's quite simple)
> #define CAP_SYS_NICE         23
> #define CAP_IPC_LOCK         14
> cpu scheduler affinity isn't part of 2.4 AFAIK
> so there is no easy way to 'control' it ...

at least I have a patch in my 2.4-tree where a user in a predefined GID 
(changeable via /proc) can change his/her nice of his/her own processes up 
and down.

ciao, Marc
