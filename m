Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282378AbRLVUvt>; Sat, 22 Dec 2001 15:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282597AbRLVUvj>; Sat, 22 Dec 2001 15:51:39 -0500
Received: from mnh-1-06.mv.com ([207.22.10.38]:39688 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S282511AbRLVUva>;
	Sat, 22 Dec 2001 15:51:30 -0500
Message-Id: <200112222211.RAA08992@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andreas Kinzler <akinzler@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Injecting packets into the kernel 
In-Reply-To: Your message of "Sat, 22 Dec 2001 21:22:06 +0100."
             <20011222202340Z282222-18284+6230@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Dec 2001 17:11:49 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akinzler@gmx.de said:
> but the packets written to such a device have no effect, they do not
> seem to make their way through the kernel.

Hmmm, well that's exactly what UML does and its packets are treated in
exactly the way you seem to want.  They are treated as coming from a totally
different machine (although UML, as a complete machine, has a complete network
stack, network devices with their own IP addresses, etc, so you might just
not be making your packets look "remote" enough).

				Jeff

