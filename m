Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSGXQMh>; Wed, 24 Jul 2002 12:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317388AbSGXQMg>; Wed, 24 Jul 2002 12:12:36 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:13843 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317387AbSGXQMg>;
	Wed, 24 Jul 2002 12:12:36 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Neil Brown <neilb@cse.unsw.edu.au>
Date: Wed, 24 Jul 2002 18:15:19 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PATCH - mark 2: type safe(r) list_entry repacement: con
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <86E5A7A57@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jul 02 at 22:38, Neil Brown wrote:
> 
> With the "typeof" suggestion from Kevin, I could just change
> list_entry and not woory about the fact that lots of people use
> "list_entry" for things that aren't lists.... but I didn't.

Hello,
  is list_entry name really that bad? We have well established 
list_entry name since at least 2.2.0, and having two same functions 
with two different names will (IMHO) cause more damage than benefit 
from "clearer" name is.
                                        Thanks,
                                            Petr Vandrovec
                                            
P.S.: I converted whole matroxfb to use
list_entry(xxx, struct matrox_fb_info, fbcon) instead of
(struct matrox_fb_info*)xxx so that I can move fbcon field from 
first position in matrox_fb_info - so I'm personally interested
in backward source compatibility.
