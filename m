Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbTDTVjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTDTVjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:39:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30629 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263713AbTDTVjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:39:11 -0400
Date: Sun, 20 Apr 2003 14:43:36 -0700 (PDT)
Message-Id: <20030420.144336.74721439.davem@redhat.com>
To: Andries.Brouwer@cwi.nl
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] new system call mknod64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <UTC200304202126.h3KLQO623927.aeb@smtp.cwi.nl>
References: <UTC200304202126.h3KLQO623927.aeb@smtp.cwi.nl>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andries.Brouwer@cwi.nl
   Date: Sun, 20 Apr 2003 23:26:24 +0200 (MEST)
   
   Such an abstract statement nobody can disagree with.
   Do you have an opinion in the mknod case?
   
If you are trying to reach 64-bit dev_t's, why not
use __u64 as the argument?

What I wouldn't be happy with would be any usage of
"long" or pointers as that is the usual source of troubles.
