Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTBUQrp>; Fri, 21 Feb 2003 11:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbTBUQrp>; Fri, 21 Feb 2003 11:47:45 -0500
Received: from [212.156.4.132] ([212.156.4.132]:36838 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267577AbTBUQrn>;
	Fri, 21 Feb 2003 11:47:43 -0500
Date: Fri, 21 Feb 2003 18:57:55 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: Janek Hiis <janekh@cvotech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.62: /proc/ide/via reads return incomplete data, Bug #374
Message-ID: <20030221165755.GA5685@ttnet.net.tr>
Mail-Followup-To: Janek Hiis <janekh@cvotech.com>,
	linux-kernel@vger.kernel.org
References: <20030220215519.GA1181@ttnet.net.tr> <Pine.LNX.4.44.0302210924001.18867-100000@cat.cvo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302210924001.18867-100000@cat.cvo>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Isn't there another problem ? As I can see the amd74xx.c has also the same 
> return in amd74xx_get_info(..) :
> 
> 	return p - buffer;
> 
> I don't have such hardware to test but there might be the same error ?

Yes, there are other drivers that have the same problem. I was planning to
send patches for them, as well.
So, if this patch fixes your problem, could you please change the bug status
to RESOLVED. Thanks.

