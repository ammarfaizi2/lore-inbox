Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132928AbRDEPgB>; Thu, 5 Apr 2001 11:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132930AbRDEPfv>; Thu, 5 Apr 2001 11:35:51 -0400
Received: from [213.97.45.174] ([213.97.45.174]:3335 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S132928AbRDEPfp>;
	Thu, 5 Apr 2001 11:35:45 -0400
Date: Thu, 5 Apr 2001 17:34:18 +0200 (CEST)
From: Pau <linuxnow@terra.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3-ac3 XIRCOM_CB only working as module
In-Reply-To: <3ACC6425.CBF6BCC4@oracle.com>
Message-ID: <Pine.LNX.4.33.0104051731570.1819-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Alessandro Suardi wrote:

> It looks like the new xircom_cb driver only works as module - if built
>  in kernel there is no sign of eth0 setup.

Built as a module works beutifully :) No need to "ifconfig -promisc" to
make it work after a suspend.

Anyway, you still have to unload the card and reload it again to get back
the network working. I'm using hotplug.

Pau

