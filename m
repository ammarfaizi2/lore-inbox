Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269024AbUIMWqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbUIMWqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUIMWqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:46:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59324 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269007AbUIMWoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:44:14 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.9-rc1-mm5 bug in tcp_recvmsg?
Date: Mon, 13 Sep 2004 15:44:07 -0700
User-Agent: KMail/1.7
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org> <200409131456.31265.jbarnes@engr.sgi.com> <20040913153620.77175c0e.davem@davemloft.net>
In-Reply-To: <20040913153620.77175c0e.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131544.07365.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 13, 2004 3:36 pm, David S. Miller wrote:
> On Mon, 13 Sep 2004 14:56:31 -0700
>
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > Shortly after the backtrace I've already posted, I got one panic that
> > looked like this:
>
> Do you have PREEMPT enabled with VLAN?  If so, that's been fixed
> recently, it was some buggy RCU locking in the VLAN code.

Nope, VLAN isn't set:
[jbarnes@tomahawk linux-2.6.9-rc1-mm5]$ grep VLAN .config
# CONFIG_VLAN_8021Q is not set
