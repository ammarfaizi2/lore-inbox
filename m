Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278441AbRJMXJj>; Sat, 13 Oct 2001 19:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278440AbRJMXJ3>; Sat, 13 Oct 2001 19:09:29 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:51210 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S278438AbRJMXJX>;
	Sat, 13 Oct 2001 19:09:23 -0400
Message-Id: <200110132309.f9DN9Z8l027418@sleipnir.valparaiso.cl>
To: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
Subject: Re: crc32 cleanups 
In-Reply-To: Message from Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de> 
   of "Sat, 13 Oct 2001 12:07:48 +0200." <Pine.LNX.4.30.0110131202070.1076-100000@stud.fbi.fh-darmstadt.de> 
Date: Sat, 13 Oct 2001 19:09:34 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de> said:
> That doesn't solve the problem, if your kernel doesn't use the crc
> functions but an externel one (special driver - eventually binary) module
> needs the code. The external driver may give a message like "crc functions
> needed - please recompile your kernel with crc support". Is this ok for
> the normal user ?

Make it a configure option, forced by drivers that need them and up to the
builder otherwise (default to "yes", I'd suppose).

Going a bit further, there are several cases of "library" stuff in the
kernel (CRC, gzip come to mind). Dunno if it is enough stuff to set up a
specific policy and perhaps CML support (or suggestions on how to use CML2
for this case).
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
