Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbSJARV0>; Tue, 1 Oct 2002 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbSJARIc>; Tue, 1 Oct 2002 13:08:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262216AbSJARCT>;
	Tue, 1 Oct 2002 13:02:19 -0400
Message-ID: <3D99D640.8030301@pobox.com>
Date: Tue, 01 Oct 2002 13:07:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@elipse.com.br>
CC: Kent Yoder <key@austin.ibm.com>, linux-kernel@vger.kernel.org,
       tsbogend@alpha.franken.de
Subject: Re: [PATCH] pcnet32 cable status check
References: <Pine.LNX.4.44.0210011129330.14607-100000@ennui.austin.ibm.com> <029401c2696a$9adc8bb0$1c00a8c0@elipse.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio wrote:
>     Also, you shouldn't need the timer stuff to keep track of link change.
> Just the mii_check_media and netif_carrier_{on|off} and you should be fine.

That depends on the hardware, specifically the presence of a reliable 
link interrupt....


