Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSFDWNw>; Tue, 4 Jun 2002 18:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSFDWMo>; Tue, 4 Jun 2002 18:12:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13954 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316891AbSFDWLH>;
	Tue, 4 Jun 2002 18:11:07 -0400
Date: Tue, 04 Jun 2002 15:07:57 -0700 (PDT)
Message-Id: <20020604.150757.10296659.davem@redhat.com>
To: paulus@samba.org
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.20 on alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15613.14457.3095.983212@argo.ozlabs.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Wed, 5 Jun 2002 08:00:25 +1000 (EST)
   
   I can see two solutions: either rename "unused_initcall" to "sys_init"
   or something similar and use it for sys_bus_init

See similar postings on this topic, with Subject
"Re: [2.5.19] Oops during PCI scan on Alpha"

There is a patch at the end of the thread which does
exactly as you describe.
