Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311688AbSCTHeR>; Wed, 20 Mar 2002 02:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311691AbSCTHeH>; Wed, 20 Mar 2002 02:34:07 -0500
Received: from www.wen-online.de ([212.223.88.39]:4100 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S311688AbSCTHeD>;
	Wed, 20 Mar 2002 02:34:03 -0500
Date: Wed, 20 Mar 2002 08:46:27 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Urban Widmark <urban@teststation.com>
cc: Andreas Dilger <adilger@clusterfs.com>, John Jasen <jjasen1@umbc.edu>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reading your email via tcpdump
In-Reply-To: <Pine.LNX.4.44.0203192147590.27806-100000@cola.teststation.com>
Message-ID: <Pine.LNX.4.10.10203200833560.1097-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Urban Widmark wrote:

> I'm guessing that Mike ran tcpdump with no -s parameter. The tcpdump

Correct.

> Like you say, if the tcpdump was running while the email was received on
> Mike's box it is possible that it had that data in some buffer. When it
> later got this message (in another buffer) and tried to decode it, it
> decoded the length the message said it had and simply spewed out random
> bytes from memory.

Hmm.  There were other 'packets' containing binary data and ascii which I'm
pretty sure was not part of any network traffic.

I'll repeat this, and post a follow-up if I see anything which is definitely
not received data.  For now, I'll assume that it's a harmless tcpdump booboo.

	Thanks,

	-Mike

