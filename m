Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSAWLuh>; Wed, 23 Jan 2002 06:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289811AbSAWLuT>; Wed, 23 Jan 2002 06:50:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14464 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289812AbSAWLuG>;
	Wed, 23 Jan 2002 06:50:06 -0500
Date: Wed, 23 Jan 2002 03:47:55 -0800 (PST)
Message-Id: <20020123.034755.104030619.davem@redhat.com>
To: wli@holomorphy.com
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
        andrea@suse.de, alan@redhat.com, akpm@zip.com.au,
        vherva@niksula.hut.fi
Subject: Re: Athlon/AGP issue update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020123033942.B899@holomorphy.com>
In-Reply-To: <200201231010.g0NAAuE05886@Port.imtp.ilyichevsk.odessa.ua>
	<20020123.022441.21593293.davem@redhat.com>
	<20020123033942.B899@holomorphy.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Wed, 23 Jan 2002 03:39:42 -0800
   
   as there is essentially no infrastructure
   for controlling the cacheable attribute(s) of user mappings now as
   I understand it.
   
Yes there most certainly are.  The driver's MMAP method can fully edit
the page protection attributes for that mmap area as it pleases.

Franks a lot,
David S. Miller
davem@redhat.com
