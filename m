Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290518AbSAQX15>; Thu, 17 Jan 2002 18:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290519AbSAQX1g>; Thu, 17 Jan 2002 18:27:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15757 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290518AbSAQX1a>;
	Thu, 17 Jan 2002 18:27:30 -0500
Date: Thu, 17 Jan 2002 15:26:19 -0800 (PST)
Message-Id: <20020117.152619.22015630.davem@redhat.com>
To: balbir_soni@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <F111UkBAB7pNKpuQZmq00002b82@hotmail.com>
In-Reply-To: <F111UkBAB7pNKpuQZmq00002b82@hotmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Balbir Singh" <balbir_soni@hotmail.com>
   Date: Thu, 17 Jan 2002 15:20:14 -0800
   
   Depending on the length passed to me in getpeername,
   I fill in the correct members and return it back.

What broken protocol works like this?
   
   Even if we do not pass the value passed by the user
   to the protocol specific code, I would like to cleanup
   the code in socket.c to check for invalid values
   upfront and save time and space in all the calls.

Optimizing error cases never bears any fruit.
