Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316239AbSEQOaF>; Fri, 17 May 2002 10:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316240AbSEQOaD>; Fri, 17 May 2002 10:30:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16285 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316239AbSEQO35>;
	Fri, 17 May 2002 10:29:57 -0400
Date: Fri, 17 May 2002 07:16:33 -0700 (PDT)
Message-Id: <20020517.071633.67125480.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: ink@jurassic.park.msu.ru, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CE512A7.70202@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Fri, 17 May 2002 10:24:39 -0400

   I know -- that's what I mean by being more explicit.  sysdata would 
   become a pointer to struct pci_domain.
   
No thanks, I want to say what the layout is for
this object.  What pci_domain will end up doing is
making for one more dereference to "arch private"
state and that stinks for performance :-)

Franks a lot,
David S. Miller
davem@redhat.com
   
   
   
