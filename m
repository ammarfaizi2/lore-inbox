Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261551AbSIZWvK>; Thu, 26 Sep 2002 18:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSIZWvJ>; Thu, 26 Sep 2002 18:51:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28555 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261553AbSIZWvB>;
	Thu, 26 Sep 2002 18:51:01 -0400
Date: Thu, 26 Sep 2002 15:49:56 -0700 (PDT)
Message-Id: <20020926.154956.109059025.davem@redhat.com>
To: spotter@cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: using memset in a module
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1033080562.3371.24.camel@zaphod>
References: <1033080562.3371.24.camel@zaphod>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Shaya Potter <spotter@cs.columbia.edu>
   Date: 26 Sep 2002 18:49:22 -0400

   I have a problem using memset in a module.
   
You cannot use different compilers to build modules than
were used to build the kernel itself.

If 2.95 was used to build the kernel, and you then try to
use gcc-3.{0,1,2} to build a module that resulting module
will have little chance of working.
