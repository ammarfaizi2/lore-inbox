Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268948AbRHFTOO>; Mon, 6 Aug 2001 15:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268942AbRHFTOF>; Mon, 6 Aug 2001 15:14:05 -0400
Received: from [63.102.108.100] ([63.102.108.100]:27148 "EHLO
	normandy.sdlcomm.com") by vger.kernel.org with ESMTP
	id <S268941AbRHFTNx>; Mon, 6 Aug 2001 15:13:53 -0400
Message-ID: <3810755D5165D2118F4400104B36917AC4FD34@normandy>
From: Matt Schulkind <mschulkind@sbs.com>
To: "'linux-ppp@vger.kernel.org'" <linux-ppp@vger.kernel.org>,
        "'paulus@samba.org'" <paulus@samba.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Syncppp
Date: Mon, 6 Aug 2001 15:15:24 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.2.16 kernel, it seems that the ppp_device structure was changed to
use a pointer to the net device instead of haveing the structure contained
within, and the if_down procedure was changed accordingly to use the sppp_of
macro. But, if I take a look at the 2.4.x kernel sources, it seems only the
first change, the pointer vs. struct change was made, but the if_down
procedure was not changed. I believe this is a bug and the if_down procedure
in the 2.4.x kernel must be changed to match 2.2.16+. Could anyone confirm
this?

Please CC me personally with any replies.

-Matt Schulkind
