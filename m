Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279566AbRJ2VnK>; Mon, 29 Oct 2001 16:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279569AbRJ2VnA>; Mon, 29 Oct 2001 16:43:00 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:33713 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S279566AbRJ2Vmt>; Mon, 29 Oct 2001 16:42:49 -0500
Date: Mon, 29 Oct 2001 21:45:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Marko Rauhamaa <marko@pacujo.nu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
In-Reply-To: <200110292107.NAA09665@lumo.pacujo.nu>
Message-ID: <Pine.LNX.4.21.0110292144120.1085-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Marko Rauhamaa wrote:
> 
> I noticed that I need a pseudodevice that opens normally but blocks all
> reads (and writes). The only way out would be through a signal. Neither
> /dev/zero nor /dev/null block, but is there some other standard device
> that would do the job?
> 
> If there isn't, writing such a pseudodevice would be trivial. What
> should it be called? Any chance of including that in the kernel?

/dev/never

