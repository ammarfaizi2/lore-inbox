Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTBXXnO>; Mon, 24 Feb 2003 18:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTBXXnO>; Mon, 24 Feb 2003 18:43:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7657 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262806AbTBXXnN>;
	Mon, 24 Feb 2003 18:43:13 -0500
Date: Mon, 24 Feb 2003 15:36:51 -0800 (PST)
Message-Id: <20030224.153651.127259815.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] get skb->len right after adjusting head 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200302241338.h1ODcwGi028650@locutus.cmf.nrl.navy.mil>
References: <20030223.214513.120185268.davem@redhat.com>
	<200302241338.h1ODcwGi028650@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Mon, 24 Feb 2003 08:38:58 -0500

   In message <20030223.214513.120185268.davem@redhat.com>,"David S. Miller" writes:
   >Don't try to modify skb->{data,len} by hands, let the skb_*()
   >interfaces do it.  Use skb_pull() in this case.
   
   missed that function when i went looking for it.  again, the right way:
   
You need to resend your original patch with this fix
added as I didn't apply your original patch :-)

Thanks.
