Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312444AbSDEKLS>; Fri, 5 Apr 2002 05:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312446AbSDEKLJ>; Fri, 5 Apr 2002 05:11:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12691 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312444AbSDEKK7>;
	Fri, 5 Apr 2002 05:10:59 -0500
Date: Fri, 05 Apr 2002 02:04:43 -0800 (PST)
Message-Id: <20020405.020443.115246313.davem@redhat.com>
To: stelian.pop@fr.alcove.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020405095038.GB16595@come.alcove-fr>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stelian Pop <stelian.pop@fr.alcove.com>
   Date: Fri, 5 Apr 2002 11:50:39 +0200

   	* the client side socket passes in CLOSE-WAIT state
   	* the client issues a write on the socket which succeds.
 ...   
   Attached are sample codes for the "server" and the "client". Test
   was done on latest 2.4 and 2.5 kernels.

Your client does not do any write()'s after the shutdown call.
It simply exit(0)'s.
