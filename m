Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268453AbRG3KIk>; Mon, 30 Jul 2001 06:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268451AbRG3KIa>; Mon, 30 Jul 2001 06:08:30 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:42513 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268453AbRG3KIT>; Mon, 30 Jul 2001 06:08:19 -0400
Message-ID: <3B653211.FD28320@namesys.com>
Date: Mon, 30 Jul 2001 14:08:17 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: Matthew Gardiner <kiwiunixman@yahoo.co.nz>,
        kernel <linux-kernel@vger.kernel.org>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Christoph Hellwig wrote:
> 
 
> Reiserfs as implemented in the 2.4.2-based kernel of OpenLinux 3.1 is
> everything but stable and has a lot of issues (e.g. NFS-exporting doesn't
> work).  That is the reason why it is a) marked experimental and is completly
> unsupported (and that is written _big_ _fat_ in manuals and similar stuff)
> and b) has debugging enabled to have the additional sanity checks that are
> under this option and give addtional hints if reiserfs fails again.

The debugging won't prevent a single crash, it will only print a diagnostic that
might help to understand why it crashed.  It makes zero sense for a distro to
have it on, and I think we make that pretty clear in the help button.  It would
be nice if distros read the help buttons before selecting options when
configuring their kernels.:-/

I make no claims that users should use ReiserFS as it is in a 2.4.2 kernel....
> 
>         Christoph
> 
> --
> Of course it doesn't work. We've performed a software upgrade.
