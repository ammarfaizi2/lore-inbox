Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314230AbSDRDwx>; Wed, 17 Apr 2002 23:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314231AbSDRDww>; Wed, 17 Apr 2002 23:52:52 -0400
Received: from www.nex.net.au ([203.24.143.24]:43535 "EHLO www.nex.net.au")
	by vger.kernel.org with ESMTP id <S314230AbSDRDwv>;
	Wed, 17 Apr 2002 23:52:51 -0400
Message-ID: <3CBE4301.13B36A81@nex.net.au>
Date: Thu, 18 Apr 2002 13:52:33 +1000
From: Gary Duncan <gduncan@nex.net.au>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: gduncan@netspace.net.au, "Duncan,Gary" <gduncan@nex.net.au>
Subject: kernel 2.5.8 bug; "make xconfig" fails quickly
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



... due to the en-var at line 52 in /usr/src/linux/drivers/ide/Config.in
($CONFIG_BLK_DEV_IDE_TCQ_DEFAULT) not being quoted.

- Gary (sigh ...)
