Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135915AbRDTSfV>; Fri, 20 Apr 2001 14:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135922AbRDTSfU>; Fri, 20 Apr 2001 14:35:20 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:38666 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135915AbRDTSec>;
	Fri, 20 Apr 2001 14:34:32 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Eric S. Raymond" <esr@thyrsus.com>
Date: Fri, 20 Apr 2001 20:33:38 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Orphaned symbols in the Configure.help file
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A83B582305@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 01 at 8:54, Eric S. Raymond wrote:

Hi Eric,

> Networking:
> 
> CONFIG_SPX

This one will come back sometime. Hopefully... It is removed
for now, as code does not work (and never did). But help
text looks reasonable.

> General:
> 
> CONFIG_NCPFS_MOUNT_SUBDIR
> CONFIG_NCPFS_NDS_DOMAINS

You can remove these two. They are now mandatory for some time,
and mandatory options do not need help ;-) BTW, for 2.5 I'm planning
to remove all CONFIG_NCPFS_* options, as you can modify behavior
at mount time instead of compile time.
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
