Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbTAaHfQ>; Fri, 31 Jan 2003 02:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTAaHfQ>; Fri, 31 Jan 2003 02:35:16 -0500
Received: from rth.ninka.net ([216.101.162.244]:46787 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267714AbTAaHfQ>;
	Fri, 31 Jan 2003 02:35:16 -0500
Subject: Re: [PATCH] 8021q memory leak
From: "David S. Miller" <davem@redhat.com>
To: Michael Rozhavsky <mrozhavsky@mrv.com>
Cc: vlan@scry.wanfear.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030130182936.GC3348@mike.nbase.co.il>
References: <20030130182936.GC3348@mike.nbase.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Jan 2003 00:25:21 -0800
Message-Id: <1044001521.31979.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 10:29, Michael Rozhavsky wrote:
> There is a memory leak in vlan module of 2.4.20
> 
> When last vlan of the group is removed the group is unhashed but not
> deleted.

I think this is fixed in 2.4.21-preX already, please
verify.

