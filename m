Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289496AbSAVWfC>; Tue, 22 Jan 2002 17:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289497AbSAVWen>; Tue, 22 Jan 2002 17:34:43 -0500
Received: from ns.suse.de ([213.95.15.193]:40708 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289496AbSAVWeZ>;
	Tue, 22 Jan 2002 17:34:25 -0500
Date: Tue, 22 Jan 2002 23:34:23 +0100
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Message-ID: <20020122233423.A5741@wotan.suse.de>
In-Reply-To: <200201171351.g0HDpdK05456@bliss.uni-koblenz.de.suse.lists.linux.kernel> <mailman.1011289920.22682.linux-kernel2news@redhat.com> <20020122123220.A27968@devserv.devel.redhat.com> <20020122231702.A30689@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020122231702.A30689@wotan.suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 11:17:02PM +0100, Andi Kleen wrote:
> On Tue, Jan 22, 2002 at 12:32:20PM -0500, Pete Zaitcev wrote:
> > Andi, the patch above begs two questions in my mind:
> > 
> > 1. Why to bind to 0 (INADDR_ANY) explicitly? My patch does not bind
> > at all and expects connect() to bind automatically. It is how
> > userland works and it seems to work here as well.
> 
> No real reason. Should work too. 

Actually there is a reason. Without a bind the portmapper is unlikely
to work. 

-Andi
