Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319330AbSIFTwN>; Fri, 6 Sep 2002 15:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319363AbSIFTwN>; Fri, 6 Sep 2002 15:52:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63367 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319330AbSIFTwN>;
	Fri, 6 Sep 2002 15:52:13 -0400
Date: Fri, 06 Sep 2002 12:49:36 -0700 (PDT)
Message-Id: <20020906.124936.34476547.davem@redhat.com>
To: gh@us.ibm.com
Cc: Martin.Bligh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17nP9R-000453-00@w-gerrit2>
References: <20020906.115804.109349169.davem@redhat.com>
	<E17nP9R-000453-00@w-gerrit2>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerrit Huizenga <gh@us.ibm.com>
   Date: Fri, 06 Sep 2002 12:52:15 -0700
   
   So if apache were using a listen()/clone()/accept()/exec() combo rather than a
   full listen()/fork()/exec() model it would see most of the same benefits?

Apache would need to do some more, such as do something about
cpu affinity and do the non-blocking VFS tricks Tux does too.

To be honest, I'm not going to sit here all day long and explain how
Tux works.  I'm not even too knowledgable about the precise details of
it's implementation.  Besides, the code is freely available and not
too complex, so you can go have a look for yourself :-)
