Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTEOWoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTEOWoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:44:18 -0400
Received: from codon.com ([209.63.105.132]:31157 "HELO codon.com")
	by vger.kernel.org with SMTP id S263936AbTEOWoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:44:18 -0400
Message-ID: <013601c31b35$75309280$88693fd1@WEASEL>
From: "Fred Garvin" <fgarvin@codon.com>
To: <linux-kernel@vger.kernel.org>
References: <20030515224910.GA8375@skymoo.dyndns.org>
Subject: Re: [PATCH] Fix vesafb with large memory, this time properly
Date: Thu, 15 May 2003 16:58:09 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for apply my previous patch, but Geert Uytterhoeven noticed the
> following problem with it
>
> > video_size must be in bytes, hence it must be
> >
> > video_size = screen_info.lfb_width*screen_info.lfb_height*video_bpp/8;
>
> The attached patch, against 2.4.21-rc2, fixes this

  Thanks for fixing this.

Fred

