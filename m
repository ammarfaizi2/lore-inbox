Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUIMMAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUIMMAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUIMMAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:00:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1209 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266069AbUIMMAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:00:21 -0400
Subject: Re: [PATCH] BSD Jail LSM (2/3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com
In-Reply-To: <20040912233342.GA12097@escher.cs.wm.edu>
References: <1094847705.2188.94.camel@serge.austin.ibm.com>
	 <1094847787.2188.101.camel@serge.austin.ibm.com>
	 <1094844708.18107.5.camel@localhost.localdomain>
	 <20040912233342.GA12097@escher.cs.wm.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095072996.14355.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 11:56:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-13 at 00:33, Serge E. Hallyn wrote:
> Right now one must choose between either an ipv4 or ipv6 interface.
> Is typical ipv6 usage such that it would be preferable to be able to
> specify one of each?  

Its normal to have both yes.

A more interesting question is whether all of the "which socket for
which use" stuff could be addressed by netfilter chains run at
bind/connect time ?

