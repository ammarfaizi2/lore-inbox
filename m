Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312476AbSCYSDG>; Mon, 25 Mar 2002 13:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312482AbSCYSC5>; Mon, 25 Mar 2002 13:02:57 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:6406 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S312476AbSCYSCn>;
	Mon, 25 Mar 2002 13:02:43 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Daniel Gryniewicz <dang@fprintf.net>
Date: Mon, 25 Mar 2002 18:59:38 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Screen corruption in 2.4.18
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <7CFA0F5109@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Mar 02 at 12:07, Daniel Gryniewicz wrote:
> > On Mon, Mar 25, 2002 at 12:43:18PM +1100, Andre Pang wrote:
> > > Can somebody with a KT133/KT133A do a "lspci -n" and grep for
> > > '8305'?  If it doesn't appear, I'll send off my patch.
> > 
> > Sorry to disappoint you:
> > 
> > $ sudo lspci -n | grep 8305
> > 00:01.0 Class 0604: 1106:8305
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
> (rev 02) (KT7-RAID, KT133)
> 00:01.0 Class 0604: 1106:8305

You can try revisions. All KMxxx I saw had revision 8x, while (this) KT133
has 0x.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
