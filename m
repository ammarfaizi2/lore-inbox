Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314694AbSEBR7T>; Thu, 2 May 2002 13:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314709AbSEBR7S>; Thu, 2 May 2002 13:59:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4574 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314694AbSEBR7R>;
	Thu, 2 May 2002 13:59:17 -0400
Date: Thu, 02 May 2002 10:48:17 -0700 (PDT)
Message-Id: <20020502.104817.06390889.davem@redhat.com>
To: dalecki@evision-ventures.com
Cc: arjanv@redhat.com, rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CD16F03.9090900@evision-ventures.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Martin Dalecki <dalecki@evision-ventures.com>
   Date: Thu, 02 May 2002 18:53:23 +0200

   And then think about the fact that they are able to even *patch*
   running kernels. There is no way I can be convinced that the whole
   versioning stuff is neccessary or a good design for any purpose.

Hint: they never changes their ABIs for drivers.  This is why
they can't fix several large scale bugs in their OS.  When the
fix would break every third party Solaris driver on the planet
they simply don't do the fix until the next major relase of the
OS.

