Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbREUHM2>; Mon, 21 May 2001 03:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261741AbREUHMS>; Mon, 21 May 2001 03:12:18 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:1552 "EHLO mx5.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S261740AbREUHMD>;
	Mon, 21 May 2001 03:12:03 -0400
Date: Mon, 21 May 2001 15:11:41 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Allan Duncan <b372050@vus068.trl.telstra.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: compile failure in 2.4.5-pre4
In-Reply-To: <200105210638.QAA19887@vus068.trl.telstra.com.au>
Message-ID: <Pine.LNX.4.33.0105211509230.12707-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 101, Allan Duncan wrote:

> This addition for 2.4.5-pre4 has caused a compile failure with a parsing error:
>
> drivers/ide/ide-pci.c:711
>     		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530)
>
> In my case CONFIG_BLK_DEV_CS5530 is not defined.

if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530))
                                             ^
                   add this right-bracket ---|

Jeff

