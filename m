Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281308AbRKLIBO>; Mon, 12 Nov 2001 03:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281309AbRKLIBE>; Mon, 12 Nov 2001 03:01:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41871 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281308AbRKLIAr>;
	Mon, 12 Nov 2001 03:00:47 -0500
Date: Mon, 12 Nov 2001 00:00:34 -0800 (PST)
Message-Id: <20011112.000034.102577112.davem@redhat.com>
To: mathijs@knoware.nl
Cc: velco@fadata.bg, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix loop with disabled tasklets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.BSI.4.05L.10111120843291.9564-100000@utopia.knoware.nl>
In-Reply-To: <87hes1qp21.fsf@fadata.bg>
	<Pine.BSI.4.05L.10111120843291.9564-100000@utopia.knoware.nl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mathijs Mohlmann <mathijs@knoware.nl>
   Date: Mon, 12 Nov 2001 08:46:08 +0100 (CET)

   On 11 Nov 2001, Momchil Velikov wrote:
   > You may want to have a look at the following patches (tested by visual
   > inspection):
   
   I like this one.

I don't like these changes, just make DECLARE_TASKLET_DISABLED
and long-term tasklet_disable()'s be illegal.

There is only one abuser of this (keyboard), and it is easily cured.

Franks a lot,
David S. Miller
davem@redhat.com
