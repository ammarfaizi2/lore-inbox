Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262986AbRE1GPm>; Mon, 28 May 2001 02:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbRE1GPc>; Mon, 28 May 2001 02:15:32 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:30212 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S262986AbRE1GPX>;
	Mon, 28 May 2001 02:15:23 -0400
Message-Id: <200105280614.f4S6EE100410@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, pavenis@latnet.lv (Andris Pavenis)
Subject: Re: 2.4.4-ac[356]: network (8139too) related crashes
Date: Mon, 28 May 2001 09:14:13 +0300
X-Mailer: KMail [version 1.2.1]
Cc: dth@trinity.hoho.nl (Danny ter Haar), linux-kernel@vger.kernel.org
In-Reply-To: <E153nZj-0008La-00@the-village.bc.nu>
In-Reply-To: <E153nZj-0008La-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 May 2001 02:34, Alan Cox wrote:
> > Tried 2.4.5 and got the same problem again. Parhaps I'll sty with
> > 2.4.3-ac3 for now. At least it doesn't freeze ...
>
> Can you try 2.4.5 with the 8139too.c file from the 2.4.3-ac3 that works for
> you and report on that

Done. 

Seems that taking 8139too.o from 2.4.3-ac3 fixes the problem. 

Tortured it much more as it was required to get 2.4.4-ac[356] and 2.4.5. to 
freeze (FTP uploads and downloads totally more than 100Mb with speed about
600Kb/s, for bad version of 8138too.c about 10Mb was usually more than enough
for freezing)

Andris
