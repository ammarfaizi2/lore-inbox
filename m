Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTAJWiN>; Fri, 10 Jan 2003 17:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbTAJWiN>; Fri, 10 Jan 2003 17:38:13 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:31192 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266473AbTAJWiM>;
	Fri, 10 Jan 2003 17:38:12 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Kees Bakker <rnews@altium.nl>
Date: Fri, 10 Jan 2003 23:46:40 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.55 - loading bttv gives Unknown symbol videobuf_iol
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
X-mailer: Pegasus Mail v3.50
Message-ID: <CDEA283083C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 03 at 23:28, Kees Bakker wrote:
> With 2.5.55 I get the following error in syslog when I load bttv:
> 
> bttv: Unknown symbol videobuf_iolock

See my few minutes old patch to Rusty's depmod. It does not handle
GPL symbols, and as Gerd uses them...
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
