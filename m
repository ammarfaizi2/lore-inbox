Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286342AbRLTTDJ>; Thu, 20 Dec 2001 14:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286338AbRLTTC7>; Thu, 20 Dec 2001 14:02:59 -0500
Received: from ns01.netrox.net ([64.118.231.130]:51081 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S286327AbRLTTCw>;
	Thu, 20 Dec 2001 14:02:52 -0500
Subject: Re: Poor performance during disk writes
From: Robert Love <rml@tech9.net>
To: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Helge Hafting <helgehaf@idb.hist.no>, jlm <jsado@mediaone.net>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200112201436.fBKEa2m26640@zero.tech9.net>
In-Reply-To: <20011220132729Z286241-18285+3296@vger.kernel.org>
	<0112201629230E.01835@manta>  <200112201436.fBKEa2m26640@zero.tech9.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 20 Dec 2001 14:02:20 -0500
Message-Id: <1008874944.2779.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 09:35, Dieter N?tzel wrote:

> > Robert maintains latency measurement patch, do you use it?
> 
> Yes, I did the ReiserFS lock-break tests for him.
>  
> > Does it show where are the problems?
> 
> NO, we have no clue, yet :-(

Want to see if its the VM?  Rik van Riel has updated his 2.4-ac VM for
new kernels and added reverse page mapping (a neat feature).

It is available at:
	http://www.surriel.com/patches/2.4/2.4.16-rmap-6

Give it a whirl, you might me impressed.  If not, maybe we can scratch
the VM as the problem and stare meanly at VFS ;-)

(Note my lock-break patch will fail on the new VM.  Ignore it.  The rest
is still fine. Perhaps I'll do a lock-break for this VM later).

	Robert Love

