Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270159AbRIAGzF>; Sat, 1 Sep 2001 02:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270165AbRIAGyz>; Sat, 1 Sep 2001 02:54:55 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:32782 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S270159AbRIAGyn>;
	Sat, 1 Sep 2001 02:54:43 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
Date: 1 Sep 2001 06:17:07 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9p0vb3.1md.kraxel@bytesex.org>
In-Reply-To: <Pine.LNX.4.33.0108311244070.2899-100000@TesterTop.PolyDom> <Pine.LNX.4.33.0109010022440.1295-100000@TesterTop.PolyDom>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 999325027 1742 127.0.0.1 (1 Sep 2001 06:17:07 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Crete wrote:
>  Hi,
>  
>  Ok, I've tried removing different parts of the kernel and I have been able
>  to find that the instability (repetable freezes) start to appear when the
>  yenta_socket.o module is loaded. I dont see the link between this module
>  and the events that trigger the freezes... It crashes when I do the
>  following things: use any of the non-keyboard buttons (thinkpad buttons
>  and volume control), brightness control, etc.. These buttons fn-X
>  combination have in common that they do not generate a scancode as shown
>  by showkey.

Try -ac kernels with PNPBIOS enabled ...

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
