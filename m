Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132284AbRAFC2m>; Fri, 5 Jan 2001 21:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132041AbRAFC2b>; Fri, 5 Jan 2001 21:28:31 -0500
Received: from dialin246.pg5-nt.dusseldorf.nikoma.de ([213.54.100.246]:33518
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129324AbRAFC2R>; Fri, 5 Jan 2001 21:28:17 -0500
Date: Sat, 6 Jan 2001 03:27:15 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: "David S. Miller" <davem@redhat.com>
cc: <vonbrand@inf.utfsm.cl>, <linux-kernel@vger.kernel.org>,
        <sparclinux@vger.kernel.org>
Subject: Re: 2.4.0 on sparc64 build problems
In-Reply-To: <200101052344.PAA07261@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101060324160.13176-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, David S. Miller wrote:

> The sparc64 config should never allow you to build the amd7930 and
> dbri sbus sound drivers, that is a bug, and I'll fix that.

However, there's supposedly the same problem for sparc32, because the ISDN
support for the amd7930 apparantly never worked (it wasn't even
selectable in the kernel-config), and thus the corresponding files in
drivers/isdn/hisax were removed. Looks like this broke the sparc build.
Is anybody willing to work with me on resolving this?

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
