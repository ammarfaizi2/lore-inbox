Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbTAaJtt>; Fri, 31 Jan 2003 04:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267744AbTAaJtt>; Fri, 31 Jan 2003 04:49:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49801
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267743AbTAaJts>; Fri, 31 Jan 2003 04:49:48 -0500
Subject: Re: [PATCH] Update PnP IDE (2/6)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Belay <ambx1@neo.rr.com>
Cc: Andre Hedrick <andre@linux-ide.org>, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030130221030.GG2246@neo.rr.com>
References: <20030125201516.GA12794@neo.rr.com>
	 <Pine.LNX.4.10.10301251824510.1744-100000@master.linux-ide.org>
	 <20030129222632.GD2246@neo.rr.com>
	 <1043926921.28133.19.camel@irongate.swansea.linux.org.uk>
	 <20030130221030.GG2246@neo.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044010443.1654.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 31 Jan 2003 10:54:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 22:10, Adam Belay wrote:
> > The IDE layer does not currently handle hotplugging. It needs a lot of work
> > before that can happen
> 
> Would you suggest I remove the ide_unregister and place a error message if that area
> is ever called in the pnp ide driver or is it better to leave it in there?  I'd like
> to get this patch out soon so users can take advantage of these changes.  Becuase
> pnp does not currently support hotplugging, I doubt there will be any problems.

Leave it there then, the IDE layer will eventually develop hotplug - its taking baby steps
that way.

