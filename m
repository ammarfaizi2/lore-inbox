Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263316AbSJCOqD>; Thu, 3 Oct 2002 10:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263317AbSJCOqD>; Thu, 3 Oct 2002 10:46:03 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:33548 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263316AbSJCOqC>; Thu, 3 Oct 2002 10:46:02 -0400
Date: Thu, 3 Oct 2002 15:51:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg Ungerer <gerg@snapgear.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.40-ac1
Message-ID: <20021003155122.A20437@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, Greg Ungerer <gerg@snapgear.com>,
	linux-kernel@vger.kernel.org
References: <20021003151707.A17513@infradead.org> <200210031420.g93EK3L07983@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210031420.g93EK3L07983@devserv.devel.redhat.com>; from alan@redhat.com on Thu, Oct 03, 2002 at 10:20:03AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:20:03AM -0400, Alan Cox wrote:
> > The sepearate one is horrible maintaince wise.  Please introduce
> > CONFIG_MMU and try to make as many _files_ in mm/ conditional on
> > those.  Else use the proper ways (cond_syscall(), inline stubs) to
> > hide the differences.
> 
> The two are so different I think that keeping it seperate is actually the
> right idea personally.

Did you actually take a look?  Many files are basically the same and other
are just totally stubbed out in nommu.

