Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTAHM4D>; Wed, 8 Jan 2003 07:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTAHM4D>; Wed, 8 Jan 2003 07:56:03 -0500
Received: from mail.zmailer.org ([62.240.94.4]:13719 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267137AbTAHM4C>;
	Wed, 8 Jan 2003 07:56:02 -0500
Date: Wed, 8 Jan 2003 15:04:40 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Asterisk] DTMF noise
Message-ID: <20030108130440.GC5948@mea-ext.zmailer.org>
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E1C1CDE.8090600@sktc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 06:43:10AM -0600, David D. Hagood wrote:
> Thomas Tonino wrote:
> >Roy Sigurd Karlsbakk wrote:
> >>so - we DO NOT need a 'simplistic' DTMF decoder.
> >
> >You need a good one. But good can be simplistic, is what I'm saying.
> >
> >DTMF was designed to be easy to decode reliably. Complex doesn't 
> >automatically mean better.
> 
> I haven't looked at the code, but I'd recommend using a bank of Goertzel 
> filters -

  Do look into   drivers/isdn/isdn_audio.c     That does use  Görtzel 
  filter, but does not do complete energy comparisons -> false detections.

/Matti Aarnio
