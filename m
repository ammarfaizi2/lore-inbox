Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbSJGF1s>; Mon, 7 Oct 2002 01:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262883AbSJGF1s>; Mon, 7 Oct 2002 01:27:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22933 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262882AbSJGF1s>;
	Mon, 7 Oct 2002 01:27:48 -0400
Date: Sun, 06 Oct 2002 22:26:33 -0700 (PDT)
Message-Id: <20021006.222633.92515528.davem@redhat.com>
To: greearb@candelatech.com
Cc: hadi@cyberus.ca, andre@pyxtechnologies.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Update on e1000 troubles (over-heating!)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DA103A2.1060901@candelatech.com>
References: <Pine.GSO.4.30.0210061835350.1861-100000@shell.cyberus.ca>
	<3DA103A2.1060901@candelatech.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Sun, 06 Oct 2002 20:46:42 -0700
   
   Dave says I'm wierd and no one else sees these bizarre problems, btw :)
   
The only case where I'm really concerned about the health
of your PCI controller is the most recent case you've
reported to me where pci_find_capability(pdev, PCI_CAP_ID_PM)
fails.  That is just completely bizarre.

I hope your boards aren't being permanently harmed by your box which
is overheating.:(
