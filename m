Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTBJWeL>; Mon, 10 Feb 2003 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTBJWeL>; Mon, 10 Feb 2003 17:34:11 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:53593 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265543AbTBJWeK>; Mon, 10 Feb 2003 17:34:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.60] : drivers/video/* compile errors
Date: Mon, 10 Feb 2003 23:43:50 +0100
User-Agent: KMail/1.4.3
References: <200302102335.53302.josh@stack.nl>
In-Reply-To: <200302102335.53302.josh@stack.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302102343.50581.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 February 2003 23:35, Jos Hulzink wrote:
> Hi,
>
> drivers/video/clgenfb.c doesn't compile, for hundreds of things are
> undefined...
>
> seems the include/video/fbdev*.h files are missing in the ftp.kernel.org
> 2.5.60 ?

Err.. fbcon*.h of course...

I see now they moved...

A simple grep learns me that 15 drivers use the wrong include dir

Jos
