Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276973AbRJKVyT>; Thu, 11 Oct 2001 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276977AbRJKVyK>; Thu, 11 Oct 2001 17:54:10 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:50692 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S276973AbRJKVxy>;
	Thu, 11 Oct 2001 17:53:54 -0400
Date: Thu, 11 Oct 2001 14:46:37 -0700
From: Greg KH <greg@kroah.com>
To: Mark Atwood <mra@pobox.com>
Cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Module read a file?
Message-ID: <20011011144637.C16452@kroah.com>
In-Reply-To: <m38zehucml.fsf@flash.localdomain> <3BC60CCB.4F525A02@nortelnetworks.com> <m3zo6xswcq.fsf@flash.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3zo6xswcq.fsf@flash.localdomain>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 02:25:09PM -0700, Mark Atwood wrote:
> 
> Because the firmware is stored in volitile memory on the card, and
> vanishes on a card reset or removal, and I would like to have it Just
> Work with the pcmcia-cs package with minimal changes.

Then add a script in the proper place in the linux-hotplug [1] package,
which will run everytime your card is inserted.  This is how USB
firmware loads will be done in 2.5.

thanks,

greg k-h

[1] http://linux-hotplug.sf.net/
