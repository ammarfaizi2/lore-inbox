Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBLQus>; Mon, 12 Feb 2001 11:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129299AbRBLQui>; Mon, 12 Feb 2001 11:50:38 -0500
Received: from [64.64.109.142] ([64.64.109.142]:6151 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S129181AbRBLQud>;
	Mon, 12 Feb 2001 11:50:33 -0500
Message-ID: <3A881438.99746625@didntduck.org>
Date: Mon, 12 Feb 2001 11:50:00 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Powell <moloch16@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Programmatically probe video chipset
In-Reply-To: <20010212164358.2762.qmail@web119.yahoomail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Powell wrote:
> 
> Is there an API or other means to determine what video
> card, namely the chipset, that the user has installed
> on his machine?
> 
> Thanks,
> Paul

The only real way is to correlate the PCI id with a chipset.  This is
what XFree86 does.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
