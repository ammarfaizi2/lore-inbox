Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319230AbSHNBKW>; Tue, 13 Aug 2002 21:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319231AbSHNBKW>; Tue, 13 Aug 2002 21:10:22 -0400
Received: from pat.uio.no ([129.240.130.16]:62660 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S319230AbSHNBKV>;
	Tue, 13 Aug 2002 21:10:21 -0400
To: Christian Reis <kiko@async.com.br>
cc: eepro100@scyld.com, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] General network slowness on SIS 530 with eepro100
References: <20020813212923.L2219@blackjesus.async.com.br>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 14 Aug 2002 03:13:55 +0200
In-Reply-To: <20020813212923.L2219@blackjesus.async.com.br>
Message-ID: <shs1y92p7ho.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > Helle there,

     > I've been, for the past days, setting up a fairly big diskless
     > network based on Linux. I've chosen to use 2.4.19 as the kernel
     > because there were some hardware requirements, and for most of
     > the newer boxes, it runs fine. However, for three of the older
     > boxes, we have had some pretty odd performance and stability
     > issues. This message is about the latest one, which is an ASUS
     > P5S-B (has the infamous SIS 530 chipset) on an intel eepro100
     > card. Details:

Is all this NFS over UDP? If so, numbers should not really have
changed in 2.4.19 ( - yes my patchset changes things, but stock 2.4.19
should not be too different w.r.t 2.4.18)

Are you able to determine where in the 2.4.19-pre series the
performance dies?

Cheers,
  Trond
