Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVF2S71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVF2S71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVF2S5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:57:48 -0400
Received: from mailfe04.tele2.fr ([212.247.154.108]:53145 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262402AbVF2SvR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:51:17 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Wed, 29 Jun 2005 20:52:45 +0200
From: Frederik Deweerdt <frederik.deweerdt@gmail.com>
To: Sreeni <sreeni.pulichi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: **** How to lock memory pages?
Message-ID: <20050629185245.GA5715@gilgamesh.home.res>
Mail-Followup-To: Sreeni <sreeni.pulichi@gmail.com>,
	linux-kernel@vger.kernel.org
References: <94e67edf05062810586d6141f3@mail.gmail.com> <m1br5p3ib8.fsf@ebiederm.dsl.xmission.com> <94e67edf050629083745bb4183@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <94e67edf050629083745bb4183@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/06/05 11:37 -0400, Sreeni écrivit:
> Hi,
> 
> Is there a way to lock a particular portion of the memory pages during
> kernel bootup? I want to re-use these pages when I load my
> application. I *don't* wanna use the idea of reserving some physical
> memory and using ioremap. I want something that kernel should be able
> to manage this memory but I don't want any other application to use
> this memory.
Please note that this is a newbie advice:
I'd have a look at how the kernel reserves pages DMA usage (below 1M)

Regards,
Frederik Deweerdt

-- 
o---------------------------------------------o
| http://open-news.net : l'info alternative   |
| Tech - Sciences - Politique - International |
o---------------------------------------------o
