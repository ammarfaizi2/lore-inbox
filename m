Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRCLErX>; Sun, 11 Mar 2001 23:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbRCLErM>; Sun, 11 Mar 2001 23:47:12 -0500
Received: from [203.197.249.146] ([203.197.249.146]:62191 "EHLO
	indica.wipsys.stph.net") by vger.kernel.org with ESMTP
	id <S129478AbRCLErI>; Sun, 11 Mar 2001 23:47:08 -0500
From: "Rama Krishna Mandava" <ramakrishna.mandava@wipro.com>
Organization: wipro
To: linux-kernel@vger.kernel.org
Subject: params of register_netdev
Date: Mon, 12 Mar 2001 15:39:02 +0530
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01031215464802.06445@elinux.wipsys>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
         In my module the code as below ...syntax code from alasandro rubini
...I hope all arguments are not necessary to be initialised ....          

	struct device my_dev =
			{
			  myne_name,
			0,0,0,0,
			0x000,
			0,
			0,0,0,
			NULL,
			myne_init,
			};


int   init_module(void)
		{
			register_netdev(my_dev);
		}


the compile error generated is  :    incompatible type for argument 1 of 
				'register_netdev'..        

	Please help me out.

Thank u
srinivas


