Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTCEPe3>; Wed, 5 Mar 2003 10:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTCEPe3>; Wed, 5 Mar 2003 10:34:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267174AbTCEPe0>;
	Wed, 5 Mar 2003 10:34:26 -0500
Date: Wed, 5 Mar 2003 07:43:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving physical memory at boot time
Message-Id: <20030305074327.673e2432.rddunlap@osdl.org>
In-Reply-To: <b453mj$qpi$1@cesium.transmeta.com>
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com>
	<Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net>
	<b442s0$pau$1@cesium.transmeta.com>
	<32981.4.64.238.61.1046844111.squirrel@www.osdl.org>
	<b453mj$qpi$1@cesium.transmeta.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Mar 2003 07:04:51 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

| Followup to:  <32981.4.64.238.61.1046844111.squirrel@www.osdl.org>
| By author:    "Randy.Dunlap" <rddunlap@osdl.org>
| In newsgroup: linux.dev.kernel
| > 
| > OK, with feeling:
| > 
| > I agree with you since the boot protocol is well-defined.
| > 
| > Just to be clear, my comment was referring to
| > Documentation/kernel-parameters.txt, not to any C code.
| > 
| > And it would really be helpful to catch issues like this soon
| > after they happen...
| > 
| 
| Unfortunately last time I commented on this the response was roughly
| "well, the patch already made it into Linus' kernel, it's too late to
| fix it now."  That isn't exactly a very helpful response.

I don't see why it's too late.  How can it be too late?
Ah, because it's already made it into 2.4?

| The mem= parameter has the semantic in the i386/PC boot protocol that
| it specifies the top address of the usable memory region that begins
| at 0x100000.  It's a bit of a wart that the boot loaders have to be
| aware of this, but it's so and it's been so for a very long time.

So it's the top of the 0x100000-mem physical linear memory region
(i.e., no gaps)?

--
~Randy
