Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318715AbSH1E2a>; Wed, 28 Aug 2002 00:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSH1E22>; Wed, 28 Aug 2002 00:28:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22677 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318715AbSH1E2J>;
	Wed, 28 Aug 2002 00:28:09 -0400
Date: Tue, 27 Aug 2002 21:26:49 -0700 (PDT)
Message-Id: <20020827.212649.102436426.davem@redhat.com>
To: s.biggs@softier.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in kernel code?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D6BEF22.21951.10E69E8@localhost>
References: <3D6BD62C.581.ACEBAD@localhost>
	<20020827.203946.102043898.davem@redhat.com>
	<3D6BEF22.21951.10E69E8@localhost>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Stephen Biggs" <s.biggs@softier.com>
   Date: Tue, 27 Aug 2002 21:29:06 -0700

   You tell me.  You're saying a billion pages (((unsigned long)(~0)) >> 2) also crashes) is never 
   going to be realistically possible?

On a 32-bit system?  No.  x86 cpus are architectually limited
to 64GB of memory, shift that right by PAGE_SIZE (13) and we're
still within bounds.

Larger memory will be then be found on 64-bit systems, and hey
then the limit becomes significantly higher.

So that is exactly what I am saying, it is not realistically
possible.
