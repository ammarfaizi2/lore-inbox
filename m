Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSEWHR0>; Thu, 23 May 2002 03:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316195AbSEWHRZ>; Thu, 23 May 2002 03:17:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25567 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314389AbSEWHRY>;
	Thu, 23 May 2002 03:17:24 -0400
Date: Thu, 23 May 2002 00:03:03 -0700 (PDT)
Message-Id: <20020523.000303.46488296.davem@redhat.com>
To: szepe@pinerecords.com
Cc: JH_ML@invtools.com, sct@redhat.com, akpm@zip.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel - Ext3 & Raid patches
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020523070244.GA4370@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Thu, 23 May 2002 09:02:44 +0200

   > > 2. What is the "proper" fix for the patch collision between the raid
   > > patch and the ext3 patch in /include/linux/fs.h? 
   > 
   > Use 2.4.
   
   Impossible on sparc32 on account of the lurking SRMMU bug.
   (See yesterday's post by Joris Braakman <jorisb@nl.euro.net>.)
   
There have been several patches posted to deal with that
problem, you can apply them yourself or grab Marcelo's
current 2.4.x BK tree.
