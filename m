Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbSI3AMf>; Sun, 29 Sep 2002 20:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSI3AMf>; Sun, 29 Sep 2002 20:12:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60330 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261845AbSI3AMf>;
	Sun, 29 Sep 2002 20:12:35 -0400
Date: Sun, 29 Sep 2002 17:11:10 -0700 (PDT)
Message-Id: <20020929.171110.04716295.davem@redhat.com>
To: hch@infradead.org
Cc: ak@muc.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020929182643.C8564@infradead.org>
References: <20020929152731.GA10631@averell>
	<20020929182643.C8564@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Sun, 29 Sep 2002 18:26:43 +0100
   
   BTW, do you have any stats on the better optimization?

Unlikely since we disable strict aliasing on the gcc command
line which is why I think this suggested __malloc thing is
utterly pointless.
