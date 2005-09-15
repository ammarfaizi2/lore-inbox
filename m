Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbVIOMne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVIOMne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVIOMne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:43:34 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21217 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030341AbVIOMnd (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:43:33 -0400
Subject: Re: [PATCH 5/5] remove HAVE_ARCH_CMPXCHG
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43283B66.8080005@yahoo.com.au>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
	 <432838E8.5030302@yahoo.com.au> <432839F1.5020907@yahoo.com.au>
	 <43283B66.8080005@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Sep 2005 14:08:31 +0100
Message-Id: <1126789711.19133.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-15 at 01:01 +1000, Nick Piggin wrote:
> Is there any point in keeping this around?
> 

Not all platforms have CMPXCHG and some code wants to know about that -
eg DRI

