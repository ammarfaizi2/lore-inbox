Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbTC1XbP>; Fri, 28 Mar 2003 18:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263209AbTC1XbP>; Fri, 28 Mar 2003 18:31:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17420 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263207AbTC1XbO>;
	Fri, 28 Mar 2003 18:31:14 -0500
Date: Fri, 28 Mar 2003 15:41:14 -0800
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@digeo.com>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, aeb@cwi.nl
Subject: Re: NICs trading places ?
Message-ID: <20030328234114.GA992@kroah.com>
References: <20030328221037.GB25846@suse.de> <20030328224843.GA11980@win.tue.nl> <20030328150234.7f73d916.akpm@digeo.com> <20030328232022.GA12005@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328232022.GA12005@win.tue.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 29, 2003 at 12:20:22AM +0100, Andries Brouwer wrote:
> 
> And: ifconfig does not give the card types.
> So presently one needs both boot messages and ifconfig.
> 
> And: in some situations the system does not boot because of
> eth numbering mixup, and one never gets the opportunity to
> ask ifconfig.

ifconfig can bind cards to devices based on mac addresses.
/sbin/hotplug can also be used for this.

I recommend doing this for anyone with more than one nic card in their
machine.

thanks,

greg k-h
