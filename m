Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316804AbSFDVRa>; Tue, 4 Jun 2002 17:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSFDVR3>; Tue, 4 Jun 2002 17:17:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33409 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316804AbSFDVR2>;
	Tue, 4 Jun 2002 17:17:28 -0400
Date: Tue, 04 Jun 2002 14:14:12 -0700 (PDT)
Message-Id: <20020604.141412.112289324.davem@redhat.com>
To: mochel@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0206041403010.654-100000@geena.pdx.osdl.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Mochel <mochel@osdl.org>
   Date: Tue, 4 Jun 2002 14:10:27 -0700 (PDT)
   
   > You people are blowing this shit WAY out of proportion.  Just fix the
   > bug now and reinplement the initcall hierarchy in a seperate changeset
   > so people can actually get work done in the 2.5.x tree while you do
   > that ok?
   
   Fine. Use Ivan's; it's appended below, and will be in BK soon. 
   
   -subsys_initcall(sys_bus_init);
   +core_initcall(sys_bus_init);

Does sys_bus_init require the generic bus layer to be initialized
first?
