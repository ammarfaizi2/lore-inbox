Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271196AbRH0HiL>; Mon, 27 Aug 2001 03:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269897AbRH0HiB>; Mon, 27 Aug 2001 03:38:01 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:45582 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S268129AbRH0Hhl>; Mon, 27 Aug 2001 03:37:41 -0400
Date: Mon, 27 Aug 2001 09:35:29 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.8-ac12
Message-ID: <20010827093529.A31359@emma1.>
Mail-Followup-To: Alan Cox <laughing@shared-source.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010826171335.A9362@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010826171335.A9362@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Sun, Aug 26, 2001 at 05:13:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Alan Cox wrote:

> 
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/
> 
> 		 Intermediate diffs are available from
> 			http://www.bzimage.org
> 
> 2.4.8-ac12
> o	Merge the majority of 2.4.9 except
> 	- min/max mess
> 	- fat/isofs changes
> 	- drm changes (some collisions with other
> 			fixes)
> 	- vm/buffer handling changes
> 	- emu10k1
> 	- vfs directory type changes
> 	- nfs/nfsd/sunrpc
> 	I'm trying to make sure I can keep this testable
> 	as 2.4.9 vanilla isnt being stable on my test sets 
> 	This is basically a merge of all the "boring" bits.

2.4.9 is somewhat stable for me, here's where it bit me:

- init occasionally hangs on boot

- bridge (with netfilter patches from bridge.sf.net) kills NFS (I have
  been told bridge and fragmented traffic don't go together well and I'd
  have to change rsize/wsize to prevent fragmentation)

Is 2.4.8-ac12 "testable" or rather "stable"?
