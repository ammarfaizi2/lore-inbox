Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWFZPnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWFZPnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWFZPnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:43:41 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:65033 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1750703AbWFZPnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:43:40 -0400
Message-ID: <20060626194339.D989@castle.nmd.msu.ru>
Date: Mon, 26 Jun 2006 19:43:39 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 4/4] Network namespaces: playing and debugging
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <20060626135537.D28942@castle.nmd.msu.ru> <449FF77D.3080707@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <449FF77D.3080707@fr.ibm.com>; from "Daniel Lezcano" on Mon, Jun 26, 2006 at 05:04:29PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 05:04:29PM +0200, Daniel Lezcano wrote:
> Andrey Savochkin wrote:
> > Temporary code to play with network namespaces in the simplest way.
> > Do
> > 	exec 7< /proc/net/net_ns
> > in your bash shell and you'll get a brand new network namespace.
> > There you can, for example, do
> > 	ip link set lo up
> > 	ip addr list
> > 	ip addr add 1.2.3.4 dev lo
> > 	ping -n 1.2.3.4
> > 
> 
> Is it possible to setup a network device to communicate with the outside ?

Such device was planned for the second patchset :)
I perhaps can send the patch tomorrow.

	Andrey
