Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272315AbTHNMH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272316AbTHNMH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:07:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272315AbTHNMHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:07:54 -0400
Date: Thu, 14 Aug 2003 08:07:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Simon Haynes <simon@baydel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: File access
In-Reply-To: <67597854DA5@baydel.com>
Message-ID: <Pine.LNX.4.53.0308140803430.179@chaos>
References: <67597854DA5@baydel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003, Simon Haynes wrote:

> I am currently developing a module which I would like to configure
> via a simple text file.
>
> I cannot seem to find any information on accessing files via a kernel module.
>
> Is this possible and if so how is it done ?
>
> Many Thanks
>
> Simon.

This has become a FAQ. You make your module accept parameters
from an ioctl(). Then you use a user-mode task to read file(s)
and configure your module.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

