Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbTAaKtI>; Fri, 31 Jan 2003 05:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTAaKtI>; Fri, 31 Jan 2003 05:49:08 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:38926 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S267761AbTAaKtH>; Fri, 31 Jan 2003 05:49:07 -0500
Date: Fri, 31 Jan 2003 12:58:29 +0200
From: Michael Rozhavsky <mrozhavsky@mrv.com>
To: "David S. Miller" <davem@redhat.com>
Cc: vlan@scry.wanfear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8021q memory leak
Message-ID: <20030131105829.GA20006@mike.nbase.co.il>
References: <20030130182936.GC3348@mike.nbase.co.il> <1044001521.31979.0.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044001521.31979.0.camel@rth.ninka.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yes, you right. I've just looked in pre4 and the fix is there.

Thanks.

On Fri, Jan 31, 2003 at 12:25:21AM -0800, David S. Miller wrote:
> On Thu, 2003-01-30 at 10:29, Michael Rozhavsky wrote:
> > There is a memory leak in vlan module of 2.4.20
> > 
> > When last vlan of the group is removed the group is unhashed but not
> > deleted.
> 
> I think this is fixed in 2.4.21-preX already, please
> verify.
--
  Michael Rozhavsky
  Senior Software Engineer
  MRV International
  Tel: +972 (4) 993-6248
  Fax: +972 (4) 989-0564
  http://www.mrv.com
