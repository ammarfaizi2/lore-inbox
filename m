Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284245AbRLLAUh>; Tue, 11 Dec 2001 19:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284251AbRLLAU1>; Tue, 11 Dec 2001 19:20:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38534 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284245AbRLLAUV>;
	Tue, 11 Dec 2001 19:20:21 -0500
Date: Tue, 11 Dec 2001 16:20:11 -0800 (PST)
Message-Id: <20011211.162011.21927662.davem@redhat.com>
To: sopwith@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: knfsd and FS_REQUIRES_DEV
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112111810160.541-100000@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112111810160.541-100000@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Elliot Lee <sopwith@redhat.com>
   Date: Tue, 11 Dec 2001 19:13:48 -0500 (EST)

   I'm looking for information on knfsd's requirement that a filesystem be
   FS_REQUIRES_DEV in order to export it. Would someone point me in the right
   direction?
   
   Needing to implement some not-quite-kosher exports,

NFSD puts dev/ino into the filehandles it gives to the
client, it uses this to lookup the inode in question.
