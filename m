Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSEXIH0>; Fri, 24 May 2002 04:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317113AbSEXIHZ>; Fri, 24 May 2002 04:07:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56041 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317112AbSEXIHY>;
	Fri, 24 May 2002 04:07:24 -0400
Date: Fri, 24 May 2002 00:52:59 -0700 (PDT)
Message-Id: <20020524.005259.36212462.davem@redhat.com>
To: ww@kt.e-technik.uni-dortmund.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff misunderstanding?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020524100434.B1778@bigmac.e-technik.uni-dortmund.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you don't copy your new sk_buff members at skb_copy and
skb_clone time, nobody will ever see them.
