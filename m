Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSEPWqK>; Thu, 16 May 2002 18:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSEPWqJ>; Thu, 16 May 2002 18:46:09 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:57580 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S315171AbSEPWqI>; Thu, 16 May 2002 18:46:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Date: Thu, 16 May 2002 10:39:50 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020516180354.GA9151@k3.hellgate.ch> <Pine.LNX.3.95.1020516141423.993A-100000@chaos.analogic.com> <20020516203159.GA10868@k3.hellgate.ch>
MIME-Version: 1.0
Message-Id: <02051610375200.01074@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What tickles my curiosity is that my previous patch didn't fix the stalling
> for Ivan G. on his VT86C100A. Maybe the chip just wasn't ready to be
> restarted.
>

With your patch #2, the chip would actually "wait forever"
in some cases...it didn't timeout and recover 

