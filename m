Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130121AbQLEMyk>; Tue, 5 Dec 2000 07:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130215AbQLEMya>; Tue, 5 Dec 2000 07:54:30 -0500
Received: from 194-73-188-168.btconnect.com ([194.73.188.168]:2820 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130121AbQLEMyU>;
	Tue, 5 Dec 2000 07:54:20 -0500
Date: Tue, 5 Dec 2000 12:25:38 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre5 breaks vmware (again)
In-Reply-To: <Pine.LNX.4.21.0010162307570.918-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0012051223140.873-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

In case you haven't noticed yet -- the 'features' field of /proc/cpuinfo
has been changed again so vmware won't run anymore. The fix is just as
obvious as the previous one -- to change /usr/bin/vmware-config.pl script
from grepping for 'features' to grep for 'flags'. I think 'flags' is what
it used to be called ages ago but that is irrelevant -- everyone
presumably already changed all their software to use 'features' (I did,
for example) and forgot about the old 'flags' forever....

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
