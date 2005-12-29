Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVL2UTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVL2UTm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVL2UTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:19:42 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:27819 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750952AbVL2UTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:19:42 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Date: Thu, 29 Dec 2005 21:19:05 +0100
User-Agent: KMail/1.8.2
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
References: <20051227215351.3d581b13.khali@linux-fr.org> <200512292100.27536.zippel@linux-m68k.org> <20051229211350.4115b799.khali@linux-fr.org>
In-Reply-To: <20051229211350.4115b799.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512292119.10139.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 29 December 2005 21:13, Jean Delvare wrote:

> No, it wouldn't produce the desired effect anymore.
>
> (!VIDEO_SAA7134_ALSA || (VIDEO_SAA7134_ALSA=m && m)) makes it possible
> to compile both OSS and ALSA support as modules. Simplifying to
> !VIDEO_SAA7134_ALSA would make it impossible.

Did you try it?

bye, Roman
