Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287730AbSABOTk>; Wed, 2 Jan 2002 09:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287823AbSABOTa>; Wed, 2 Jan 2002 09:19:30 -0500
Received: from [195.66.192.167] ([195.66.192.167]:50956 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S287730AbSABOTT>; Wed, 2 Jan 2002 09:19:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Extern variables in *.c files
Date: Wed, 2 Jan 2002 16:18:04 -0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02010216180403.01928@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I grepped kernel *.c (not *.h!) files for extern variable definitions.
Much to my surprize, I found ~1500 such defs.

Isn't that bad C code style? What will happen if/when type of variable gets 
changed? (int->long).

I thought external definitions ought to be in *.h files.
Maybe I'm missing something here...
--
vda
