Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVJGPO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVJGPO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVJGPO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:14:27 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:39624 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030335AbVJGPO0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:14:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GqGDdjDgKuBoyi0j60BM/ixFGTVkspfmqpYDY8Zr2Mq+Um0OD6/NHdyy5F7EAE5DWjF/cJohGIzdLA69UqNnR/vu2ZZF9SkHj5UiXTIE/MTn/sRUnrVz2c77oR0YhGoU/LUUcTPyLr2UmyEp4Xs8jQZphaqWEc8cxvJR1wnuq6g=
Message-ID: <81b0412b0510070814v769ddb11n7e0d812a09bdf77b@mail.gmail.com>
Date: Fri, 7 Oct 2005 17:14:25 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: 'Undeleting' an open file
Cc: Ian Campbell <ijc@hellion.org.uk>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1128696194.31606.53.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4343E611.1000901@perkel.com>
	 <20051005144441.GC8011@csclub.uwaterloo.ca>
	 <4343E7AC.6000607@perkel.com>
	 <20051005153727.994c4709.fmalita@gmail.com>
	 <43442D19.4050005@perkel.com>
	 <Pine.LNX.4.58.0510052208130.4308@be1.lrz>
	 <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
	 <1128695400.28620.42.camel@icampbell-debian>
	 <1128696194.31606.53.camel@tara.firmix.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/05, Bernd Petrovitsch <bernd@firmix.at> wrote:
> > > > Files are deleted if the last reference is gone. If you play a music file
> > > > and unlink it while it's playing, it won't be deleted untill the player
> > > > closes the file, since an open filehandle is a reference.
> > > BTW, I've always wondered: is there a way to un-unlink such a file?
> > Access via /proc/PID/fd/* seems to work:
> Did you try linking it?
>

ln: creating hard link `testfile2' to `/proc/14282/fd/3': Invalid
cross-device link
Pity :)
"cp" works, btw.
