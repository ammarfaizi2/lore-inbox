Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292806AbSBVGCi>; Fri, 22 Feb 2002 01:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292807AbSBVGCb>; Fri, 22 Feb 2002 01:02:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7552 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292806AbSBVGCU>;
	Fri, 22 Feb 2002 01:02:20 -0500
Date: Thu, 21 Feb 2002 22:00:27 -0800 (PST)
Message-Id: <20020221.220027.63129195.davem@redhat.com>
To: tom_gall@vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: bug(?): SET_PERSONALITY 2.4.18-rc3
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C75B1E0.ADC9B488@vnet.ibm.com>
In-Reply-To: <3C75B1E0.ADC9B488@vnet.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tom Gall <tom_gall@vnet.ibm.com>
   Date: Thu, 21 Feb 2002 20:50:08 -0600
   
   otherwise a static application would be run without SET_PERSONALITY
   being called, which On ppc64, very quickly leads to a bad day.

This is also breaking static 32-bit apps on sparc64.
Thanks for finding this.
