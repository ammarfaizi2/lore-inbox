Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316020AbSEJPQN>; Fri, 10 May 2002 11:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316021AbSEJPQM>; Fri, 10 May 2002 11:16:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28864 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316020AbSEJPQL>;
	Fri, 10 May 2002 11:16:11 -0400
Date: Fri, 10 May 2002 08:04:05 -0700 (PDT)
Message-Id: <20020510.080405.124002004.davem@redhat.com>
To: pmanuel@myrealbox.com
Cc: chen_xiangping@emc.com, linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CDBFF5B.32550.1364FB2@localhost>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
   Date: Fri, 10 May 2002 17:11:55 +0200

      Actually there is. Think iSCSI. Have a look at this article at 
   LinuxJournal - http://linuxjournal.com/article.php?sid=4896 .

The Linux networking stack need have no hand in any of the IPv4 done
by iSCSI, it can live entirely in the cards firmware and Linux need
not know what the transport looks like at all.
