Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSCIHTH>; Sat, 9 Mar 2002 02:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292581AbSCIHRS>; Sat, 9 Mar 2002 02:17:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292444AbSCIHPD>;
	Sat, 9 Mar 2002 02:15:03 -0500
Date: Fri, 08 Mar 2002 19:47:49 -0800 (PST)
Message-Id: <20020308.194749.62676879.davem@redhat.com>
To: ionut@cs.columbia.edu
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update for 2.4.19pre2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0203071400080.3930-100000@age.cs.columbia.edu>
In-Reply-To: <20020306.141809.112819805.davem@redhat.com>
	<Pine.LNX.4.44.0203071400080.3930-100000@age.cs.columbia.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ion Badulescu <ionut@cs.columbia.edu>
   Date: Thu, 7 Mar 2002 14:13:06 -0500 (EST)

   Ahh.. indeed, changing the burst size to 64 bytes (from the default 128)  
   makes a big difference on my ultra5, thanks for the hint. Does it make any
   sense to differentiate between platforms, or is 64 a good all-around
   value?
   
Jeff and I want to add some pci_optimal_burst_size() or whatever
interface so that drivers don't get stuffed with ifdefs, but for now
use CONFIG_SPARC64 for this :-) I think on Alpha a similar situation
exists and you should use 128 instead of 64 there.

Franks a lot,
David S. Miller
davem@redhat.com
