Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310329AbSCBGf6>; Sat, 2 Mar 2002 01:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310330AbSCBGft>; Sat, 2 Mar 2002 01:35:49 -0500
Received: from 12-253-30-32.client.attbi.com ([12.253.30.32]:21699 "EHLO
	lunar.radom.org") by vger.kernel.org with ESMTP id <S310329AbSCBGfg>;
	Sat, 2 Mar 2002 01:35:36 -0500
Date: Fri, 1 Mar 2002 23:35:34 -0700
From: dan radom <dan@radom.org>
To: linux-kernel@vger.kernel.org
Subject: nfs task foo can't get a requested slot client errors
Message-ID: <20020302063533.GH6260@lunar.radom.org>
Reply-To: "dan@radom.org" <dan@radom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me in any replies, as I'm not subscribed to this list.

With recent kernel releases (2.4.17 and 18) I've had nfs client problems (nfs task foo can't get a requested slot).  I've read what I can about this error, but don't see anything pertaining to recent kernels.  Anything with a rsize or wsize greater than 3072 dies under what I'm guessing are RPC problems.  Server load isn't an issue here.  What can this be?  The nfsd is running 2.4.17, and several other 2.4.17 clients can nfs with default rsize and wsize of 8192.  I'm using a xircom 10/100/56K cardbus ethernet adapter.  Client kernel nfs config includes both CONFIG_NFS_FS=m and  CONFIG_NFS_V3=y

Thanks in advance,

dan
