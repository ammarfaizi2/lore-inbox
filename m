Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129527AbQKECte>; Sat, 4 Nov 2000 21:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQKECtY>; Sat, 4 Nov 2000 21:49:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129527AbQKECtI>; Sat, 4 Nov 2000 21:49:08 -0500
Message-ID: <3A04CA8F.D19535B1@transmeta.com>
Date: Sat, 04 Nov 2000 18:48:47 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Dominik Kubla <dominik.kubla@uni-mainz.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs. JFS file locations...
In-Reply-To: <3A02D150.E7E87398@usa.net> <200011031725.eA3HPwP12932@webber.adilger.net> <8tv3tm$iqg$1@cesium.transmeta.com> <20001105024621.A29327@uni-mainz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla wrote:
> 
> On Fri, Nov 03, 2000 at 11:33:10AM -0800, H. Peter Anvin wrote:
> >
> > How about naming it something that doesn't end in -fs, such as
> > "journal" or "jfsl" (Journaling Filesystem Layer?)
> >
> 
> Why?  I'd rather rename IBM's jfs to ibmjfs and be done with it.
> 
> Yours,
>   Dominik Kubla
> 

Because -fs is usually used by filesystems itself.  Since the journaling
layer doesn't really have a publically visible name, it's easy to change.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
