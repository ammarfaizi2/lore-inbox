Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129683AbQLENZb>; Tue, 5 Dec 2000 08:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130215AbQLENZV>; Tue, 5 Dec 2000 08:25:21 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:14341 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129683AbQLENZC>;
	Tue, 5 Dec 2000 08:25:02 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tigran Aivazian <tigran@veritas.com>
Date: Tue, 5 Dec 2000 13:54:02 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.0-test12-pre5 breaks vmware (again)
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <ECC703608DB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Dec 00 at 12:25, Tigran Aivazian wrote:

> In case you haven't noticed yet -- the 'features' field of /proc/cpuinfo
> has been changed again so vmware won't run anymore. The fix is just as
> obvious as the previous one -- to change /usr/bin/vmware-config.pl script
> from grepping for 'features' to grep for 'flags'. I think 'flags' is what
> it used to be called ages ago but that is irrelevant -- everyone
> presumably already changed all their software to use 'features' (I did,
> for example) and forgot about the old 'flags' forever....

Blessed vmware-config.pl contains

\(flags\|features\).*

so it should run...
                                                    Petr
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
