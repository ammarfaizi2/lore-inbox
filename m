Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273267AbRINC4L>; Thu, 13 Sep 2001 22:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273268AbRINC4C>; Thu, 13 Sep 2001 22:56:02 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:31251 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S273267AbRINCzo>;
	Thu, 13 Sep 2001 22:55:44 -0400
Date: Thu, 13 Sep 2001 23:56:00 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon bug stomping #2
In-Reply-To: <19425218582.20010913153137@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.21.0109132350420.24762-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, VDA wrote:

> Device 0 Offset 55 - Debug (RW)
> 7-0 Reserved (do not program). default = 0
> *** 3R BIOS: non-zero!?
> *** YH BIOS: zero.
> *** TODO: try to set to 0.

I tryed sequentially to test the values given. It only worked when I set
offset 0x55 to 0, and then stopped. I don't need to set any other value in
other addresses. This is enough.

It's weird when your system only works when changing a "do not
program" value. :)

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

