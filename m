Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274245AbRISW77>; Wed, 19 Sep 2001 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274247AbRISW7t>; Wed, 19 Sep 2001 18:59:49 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:519 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S274245AbRISW7f>;
	Wed, 19 Sep 2001 18:59:35 -0400
Date: Wed, 19 Sep 2001 20:00:28 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: Simen Thoresen <simen-tt@online.no>
cc: goemon@anime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <200109192251110218.11CA7E22@scispor.dolphinics.no>
Message-ID: <Pine.GSO.4.21.0109191958580.1374-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Simen Thoresen wrote:

> Why? by default it is '09' on my system, it does not experience any
> oops-problems, and the spec still reads it to be '00' and 'dont
> program'.
> 
> I'm now applying the patch and rebuilding the kernel to permanently zero it.

The patch is not supposed to set it to 0, only to clear bit 7, so if your
system has it as 0x09, the patch has no effect, since bit 7 is already
cleared.

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

