Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281436AbRKMCum>; Mon, 12 Nov 2001 21:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281440AbRKMCud>; Mon, 12 Nov 2001 21:50:33 -0500
Received: from zok.SGI.COM ([204.94.215.101]:5072 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281436AbRKMCuS>;
	Mon, 12 Nov 2001 21:50:18 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Changed message for GPLONLY symbols
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 13:50:09 +1100
Message-ID: <10444.1005619809@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When insmod detects a non-GPL module with unresolved symbols it
currently says:

Note: modules without a GPL compatible license cannot use GPLONLY_ symbols

I thought that hint was self-explanatory, obviously it was not clear.
Never underestimate the ability of lusers to misread a message.  insmod
2.4.12 will say

Hint: You are trying to load a module without a GPL compatible license
      and it has unresolved symbols.  The module may be trying to access
      GPLONLY symbols but the problem is more likely to be a coding or
      user error.  Contact the module supplier for assistance.

Does anyone think that this message can be misunderstood by anybody
with the "intelligence" of the normal Windoze user?

