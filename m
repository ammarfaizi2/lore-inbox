Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281268AbRLDVba>; Tue, 4 Dec 2001 16:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283469AbRLDVbU>; Tue, 4 Dec 2001 16:31:20 -0500
Received: from mail118.mail.bellsouth.net ([205.152.58.58]:4399 "EHLO
	imf18bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S283459AbRLDVbP>; Tue, 4 Dec 2001 16:31:15 -0500
Message-ID: <3C0D409C.1E4CD9F0@mandrakesoft.com>
Date: Tue, 04 Dec 2001 16:31:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Myers <rob.myers@gtri.gatech.edu>
CC: Michael Clark <michael@metaparadigm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH] - 2.4.16 ns83820 optical support (Netgear GA621)
In-Reply-To: <3C0CED3B.7030409@metaparadigm.com> <1007501048.14051.28.camel@ransom>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Myers wrote:
> are references to dev->net_dev.name valid before
> register_netdev(&dev->net_dev) in ns83820_init_one()?

no.  register_netdev is where an interface number(name) is assigned.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

