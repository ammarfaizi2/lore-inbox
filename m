Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSEWEGi>; Thu, 23 May 2002 00:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316049AbSEWEGh>; Thu, 23 May 2002 00:06:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54237 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315988AbSEWEGg>;
	Thu, 23 May 2002 00:06:36 -0400
Date: Wed, 22 May 2002 20:52:24 -0700 (PDT)
Message-Id: <20020522.205224.63641863.davem@redhat.com>
To: katta@csee.wvu.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Reg. asm-sparc64/processor.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1022115898.1418.14.camel@indus>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you want the 'u64' type, define __KERNEL__.  That is what
every platform does, protect the types without underscores with
a __KERNEL__ ifdef.

