Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316613AbSE0VqF>; Mon, 27 May 2002 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSE0VqE>; Mon, 27 May 2002 17:46:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30450 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316613AbSE0VqE>; Mon, 27 May 2002 17:46:04 -0400
Subject: Re: Memory management in Kernel 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <acu82e$7qn$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 23:48:46 +0100
Message-Id: <1022539726.4124.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 22:22, H. Peter Anvin wrote:
> Followup to:  <1022513156.1126.289.camel@irongate.swansea.linux.org.uk>
> By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
> In newsgroup: linux.dev.kernel
> > 
> > On a -ac kernel with mode 2 or 3 set for overcommit you have to run out
> > of kernel resources to hang the box. It won't go OOM because it can't.
> > That wouldn't be a VM bug but a leak or poor handling of kernel
> > allocations somewhere. Sadly the changes needed to do that (beancounter
> > patch) were things Linus never accepted for 2.4
> > 
> 
> Well, if you can't fork a new process because that would push you into
> overcommit, then you usually can't actually do anything useful on the
> machine.

Thats actually easy to deal with and on my list for modes 4 and 5 (2 and
3 with root granted a reserved fraction)

