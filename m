Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbSJAJ65>; Tue, 1 Oct 2002 05:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSJAJ65>; Tue, 1 Oct 2002 05:58:57 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:27614 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261537AbSJAJ64>;
	Tue, 1 Oct 2002 05:58:56 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: kraxel@bytesex.org
Date: Tue, 1 Oct 2002 12:04:04 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: V4L2? (was Re: Linux v2.5.40 - and a feature freeze reminder)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <359D88D39E2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Oct 02 at 0:32, Linus Torvalds wrote:
> 
> And a small reminder that we're now officially in the last month of
> features, and since I'm going to be away basically the last week of
> October, so I actually personally consider Oct 20th to be the drop-date,
> unless you've got a really good and scary costume.. So don't try to leave 
> it to the last day.

Gerd,
  do you have any plans for V4L2 being in 2.6 or not? There is still
sitting patch which allows you to control hue/brightness/saturation/contrast
on matroxfb's TVOut in my tree, waiting for V4L2 API defines. 
Should I send current patch (which defines matroxfb_queryctrl,
matroxfb_ctrl_type, MATROXFB_CID_*... binary compatible with its
video4linux2 counterparts), or should I wait?

  I'd like to have this extension in matroxfb before 2.6, as G450's
and G550's TVOuts differ from piece to piece, and default setting
does not fit for everyone...
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
