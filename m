Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271832AbRIMQl3>; Thu, 13 Sep 2001 12:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRIMQlT>; Thu, 13 Sep 2001 12:41:19 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:19974 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S271836AbRIMQlN>;
	Thu, 13 Sep 2001 12:41:13 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Kent Borg <kentborg@borg.org>
Date: Thu, 13 Sep 2001 18:41:11 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Novell Client End?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <35B26BF008B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 01 at 12:30, Kent Borg wrote:

> Has anyone ever done any Linux work on Novell protocols--but the
> client end?  (Specifically, for a printer?)

What do you think by this? You can use 'pserver' from ncpfs, which
attaches to some job queue on Netware server and processes jobs in the
queue.

If you are talking about rprinter protocol, then you are lost, as rprinter
needs SPX, and SPX implementation in Linux is a bit fragile - and besides
that, you can configure Netware Printserver to use lpd protocol, so there
is no need for that.

If you have further questions, you should join linware@sh.cvut.cz (send
subscribe linware to listserv@sh.cvut.cz), IPX & NCP are discussed there
(long ago there was linux-ipx on vger.rutgers.edu, but it is really long
time ago).
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
