Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271685AbRICMw0>; Mon, 3 Sep 2001 08:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271690AbRICMwR>; Mon, 3 Sep 2001 08:52:17 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:64530 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S271685AbRICMv6>;
	Mon, 3 Sep 2001 08:51:58 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Benjamin Gilbert <bgilbert@backtick.net>
Date: Mon, 3 Sep 2001 14:51:44 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb problems with dualhead G400
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <26751224E05@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Sep 01 at 0:25, Benjamin Gilbert wrote:
> I've been trying to set up dualhead text console with matroxfb and a
> 16MB G400, with mixed success.  What I think I'm seeing is that the
> scrollback from the primary head, when it gets long enough (i.e., cat
> /boot/System.map), intrudes on the secondary head.  If the secondary
> head is set to the same resolution and bit depth as the primary, I

> Kernel is vanilla 2.4.9.  Let me know what other information you need
> from me.

You must boot your kernel with 'video=scrollback:0'. Otherwise your
kernel die sooner or later... JJ's scrollback code does not cope with
more than one visible console, so you must disable it if you have more
than one display in the box.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
