Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292749AbSBZTpO>; Tue, 26 Feb 2002 14:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292762AbSBZTpE>; Tue, 26 Feb 2002 14:45:04 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:37896 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S292749AbSBZTo6>;
	Tue, 26 Feb 2002 14:44:58 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Denis Zaitsev <zzz@cd-club.ru>
Date: Tue, 26 Feb 2002 20:43:45 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] matroxfb_base.c - a little fix
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <12EE5C947552@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 02 at 0:26, Denis Zaitsev wrote:
> It was two identical if-else branches in matroxfb_decode_var - one for
>         var->bits_per_pixel == 4
> and the other for
>         var->bits_per_pixel <= 8
> .  So, I've removed 4's one.  It should be ok, if this branch was ok -
> i.e. was intentionally made the same as the 8bpp's.  So, Petr, please,
> apply this fix, if all ok.

Somebody changed == 8 to <= 8 when I was not looking... But as
bits_per_pixel is already validated, it looks correct. Applied,
will go to Linus next round.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
