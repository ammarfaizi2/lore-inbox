Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278675AbRJSWK5>; Fri, 19 Oct 2001 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278678AbRJSWKh>; Fri, 19 Oct 2001 18:10:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21382 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278675AbRJSWKd>;
	Fri, 19 Oct 2001 18:10:33 -0400
Date: Fri, 19 Oct 2001 15:11:01 -0700 (PDT)
Message-Id: <20011019.151101.21914602.davem@redhat.com>
To: bcrl@redhat.com
Cc: ak@muc.de, sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011019180433.H9206@redhat.com>
In-Reply-To: <20011019173055.G9206@redhat.com>
	<20011019.145639.59667516.davem@redhat.com>
	<20011019180433.H9206@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Fri, 19 Oct 2001 18:04:34 -0400
   
   If the hash table was grown dynamically, I wouldn't have this complaint.
   
It's too expensive to implement.  It adds a new check every
connection, _or_ some timer which periodically scans the chain
lengths.

Franks a lot,
David S. Miller
davem@redhat.com
