Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTETRw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbTETRw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:52:28 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:32212 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263270AbTETRw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:52:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dave Jones <davej@codemonkey.org.uk>
Date: Tue, 20 May 2003 20:05:12 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
Cc: Brett <generica@email.com>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org
X-mailer: Pegasus Mail v3.50
Message-ID: <2110DE22C31@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 03 at 18:18, Dave Jones wrote:
> On Tue, May 20, 2003 at 05:55:41PM +0100, James Simmons wrote:
> 
>  > > Wasn't the EDID stuff getting backed out anyways ?
>  > Only in the VESA driver. Some people did have luck with the BIOS EDID info 
>  > so I like to keep the BIOS call in there. 
> 
> That code runs way earlier than before we get to do any PCI quirks,
> so fixing that one up could be interesting.

On my system (G450 + Compaq MV600 + TV) this EDID call takes about 
5 seconds (fortunately it does not die), so I'll be happy if I can config
this out - especially as matroxfb gives you DDC access from inside Linux.
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

