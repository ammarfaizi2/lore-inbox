Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129886AbQK1Cbx>; Mon, 27 Nov 2000 21:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130146AbQK1Cbn>; Mon, 27 Nov 2000 21:31:43 -0500
Received: from mail2.rdc2.on.home.com ([24.9.0.41]:252 "EHLO
        mail2.rdc2.on.home.com") by vger.kernel.org with ESMTP
        id <S129886AbQK1Cbc>; Mon, 27 Nov 2000 21:31:32 -0500
Message-ID: <3A231197.A62DE01F@cmedia.com.tw>
Date: Mon, 27 Nov 2000 20:59:51 -0500
From: cmedia <cltien@cmedia.com.tw>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux driver for c-media cm8x38 ver 4.12 released
In-Reply-To: <3A1C62AA.5D4579B3@cmedia.com.tw>
                <20001123033948.R2918@wire.cadcamlab.org>
                <3A1D1998.5A22EA7C@cmedia.com.tw> <14877.10577.518203.721355@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I change it so a release 4.14 posted at
http://members.home.net/puresoft/cmedia.html. This version has no functional
change.

Sincerely,
ChenLi Tien

Peter Samuelson wrote:

> [ChenLi Tien]
> > > I don't think the (2,3,0) ifdef is necessary.  Just use the labeled
> > > initializers for all kernels.  See also cm_audio_fops, cm_dsp_fops,
> > > cm_midi_fops, cm_dmfm_fops.
> >
> > Yes, as 2.3.x series is not for end-user, I can remove them. I keep it for
> > easy to tell what's different for kernel 2.3 and 2.4.
>
> What I meant was, the code which you have '#if version >= 2.3.0' is
> also valid for 2.2.  You should not have any conditional code there
> except the 'owner:' member, which is '#if version >= 2.4.0'.
>
> > > No need for '#ifdef MODULE'.
> >
> > I will remove it if kernel 2.2 can work.
>
> It can.  I checked 2.2.0.
>
> Peter

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
