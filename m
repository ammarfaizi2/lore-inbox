Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135283AbRAVVTn>; Mon, 22 Jan 2001 16:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135342AbRAVVTc>; Mon, 22 Jan 2001 16:19:32 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:27910 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135283AbRAVVTV>;
	Mon, 22 Jan 2001 16:19:21 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: f5ibh <f5ibh@db0bm.ampr.org>
Date: Mon, 22 Jan 2001 22:16:18 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: display problem with matroxfb
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <13554C4167C1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 01 at 22:11, f5ibh wrote:
> >Are you sure that you did not enabled both vesafb and matroxfb? They cannot
> >work together. Also, does this happen only in 8bpp mode, or does this
> >happen in other color depths too?
> 
> Yes, sure. I've read the docs and tested with vesafb enabled OR matroxfb
> enabled, never both.
> This happens with both 8bpp or 16bpp. 
> 
> Is there a specific configuration file for the matrox ? 

No, only kernel options described in linux/Documentation/fb/matroxfb.txt.
Can you try 'video=matrox:vesa:0x105'? And does this happen if you'll
do 'fbset -accel false', or if you boot with 'video=matrox:noaccel' ?
                                        Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
