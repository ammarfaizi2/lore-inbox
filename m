Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281631AbRKUG53>; Wed, 21 Nov 2001 01:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281633AbRKUG5L>; Wed, 21 Nov 2001 01:57:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10384 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281631AbRKUG46>;
	Wed, 21 Nov 2001 01:56:58 -0500
Date: Tue, 20 Nov 2001 22:56:55 -0800 (PST)
Message-Id: <20011120.225655.85404918.davem@redhat.com>
To: jmerkey@timpanogas.org
Cc: jmerkey@vger.timpanogas.org, linux-kernel@vger.kernel.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
 opcode
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <000601c17259$59316630$f5976dcf@nwfs>
In-Reply-To: <20011121003304.A683@vger.timpanogas.org>
	<20011120.224723.35806752.davem@redhat.com>
	<000601c17259$59316630$f5976dcf@nwfs>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Jeff Merkey" <jmerkey@timpanogas.org>
   Date: Tue, 20 Nov 2001 23:54:21 -0700
   
   I am building an NWFS module external of the kernel tree, and unless make
   dep
   has been run, the default behavior of the includes causes me to drop into
   the
   BUG() trap.

When you change configuration options, you have to run make
dep again, that is a known requirement of the 2.4.x build system
like it or not :-)
