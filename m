Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbTEBVgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTEBVgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:36:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:14913 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263177AbTEBVgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:36:16 -0400
Message-ID: <3EB2E7B1.40006@gmx.net>
Date: Fri, 02 May 2003 23:48:33 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> Furthermore, the kernel also remaps all PROT_EXEC mappings to the
> so-called ASCII-armor area, which on x86 is the addresses 0-16MB. These
[snipped]
> In the above layout, the highest executable address is 0x01003fff, ie.
> every executable address is in the ASCII-armor.

If my math is correct,
0x01000000 is 16 MB boundary
0x01003fff is outside the ASCII-armor.

Another question:
Last time I checked, there were some problems with binary only drivers
(to name one, NVidia graphics) and a non-executable stack. Has this been
resolved?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

