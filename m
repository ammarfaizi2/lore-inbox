Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTAEDSI>; Sat, 4 Jan 2003 22:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbTAEDSI>; Sat, 4 Jan 2003 22:18:08 -0500
Received: from viefep12-int.chello.at ([213.46.255.25]:19024 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id <S262604AbTAEDSI>; Sat, 4 Jan 2003 22:18:08 -0500
Message-ID: <02a101c2b46a$47d79900$6400a8c0@twister>
From: "NEURONET" <sz@neuronet.hu>
To: "Andrew Morton" <akpm@digeo.com>,
       "Andre Hedrick" <andre@pyxtechnologies.com>
Cc: "Rik van Riel" <riel@conectiva.com.br>, "Richard Stallman" <rms@gnu.org>,
       <andrew@indranet.co.nz>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10301041740090.421-100000@master.linux-ide.org> <3E179CCF.F4CAE1E5@digeo.com>
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Date: Sun, 5 Jan 2003 04:26:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that a piece of kernel functionality happens to be inlined
> is a pure technical detail of linkage.

Absolutely.

> If there really is inlined functionality which we do not wish made
> available to non-GPL modules then it should be either uninlined and
> not exported or it should be wrapped in #ifdef GPL.

I don't even think there should be any such case, 
as the real point in having LGPL is, supposedly, to 
support *interfacing*, so using headers (source-code 
*interfaces*) and linking to stuff (binding binary 
*interfaces*) should be just fine under LGPL (or a 
better LGPL? IGPL? dunno the details that deep, sorry).

Sab

