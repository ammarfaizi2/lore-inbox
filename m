Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbREaQAZ>; Thu, 31 May 2001 12:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbREaQAP>; Thu, 31 May 2001 12:00:15 -0400
Received: from motgate3.mot.com ([144.189.100.103]:29146 "EHLO
	motgate3.mot.com") by vger.kernel.org with ESMTP id <S262663AbREaQAD>;
	Thu, 31 May 2001 12:00:03 -0400
Message-Id: <3B166A44.F1A8B0A@crm.mot.com>
Date: Thu, 31 May 2001 17:59:00 +0200
From: Emmanuel Varagnat <varagnat@crm.mot.com>
Organization: Motorola
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: sk_buff question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I need to had a header to the data in the sk_buff.
But what to do if there is no enough space left at the head ?
I saw skb_copy_expand, but it gives me a new sk_buff. Is there
a way to expand the headroom and keep the pointer on the sk_buff ?

Thanks

-Manu
