Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132415AbRAKHeL>; Thu, 11 Jan 2001 02:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132567AbRAKHeD>; Thu, 11 Jan 2001 02:34:03 -0500
Received: from ns1.megapath.net ([216.200.176.4]:31748 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S132415AbRAKHdu>;
	Thu, 11 Jan 2001 02:33:50 -0500
Message-ID: <3A5D6196.9020806@megapathdsl.net>
Date: Wed, 10 Jan 2001 23:32:38 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac1 i686; en-US; m18) Gecko/20010107
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: Aaron Eppert <eppertan@rose-hulman.edu>, dhinds@zen.stanford.edu,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Patch for 3c575
In-Reply-To: <20010110204420.A7699@rose-hulman.edu> <3A5D20D6.6090906@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:

> Huh.  Well, I have a 3CCFE575BT "3c575" card and I have
> had success using the 3c59x driver to enable the card.

I just realised that I was not explicit before:

I do not think this port of 3c575_cb should go into the
kernel, since the device is already supported by 3c59x,
unless there is some substantial benefit from using
the 3c575_cb driver instead.  Is there substantial
benefit?

Miles



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
