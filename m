Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSEaN35>; Fri, 31 May 2002 09:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSEaN34>; Fri, 31 May 2002 09:29:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:12029 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315278AbSEaN3z>; Fri, 31 May 2002 09:29:55 -0400
Subject: Re: [PATCH] Submitting PROMISE IDE Driver Patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hank Yang <hanky@promise.com.tw>
Cc: andre@linux-ide.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        arjanv@redhat.com, Linus Chen <linusc@promise.com.tw>,
        Crimson Hung <crimsonh@promise.com.tw>
In-Reply-To: <039701c20892$3940ca30$c0cca8c0@promise.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 May 2002 15:33:12 +0100
Message-Id: <1022855592.4124.415.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-31 at 11:59, Hank Yang wrote:
> The origin kernel 2.4.18 do not support LBA48 yet, So it not the kernel's
> fault. I just want to know who can explain this and find a way to solve it.

Take a look at 2.4.19pre8 that should have all the pieces required, as
should the Red Hat 7.3 kernel. Andre Hedrick has been merging the LBA48
and other ide changes into the main code over the past couple of months

