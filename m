Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSAVWRV>; Tue, 22 Jan 2002 17:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289486AbSAVWRL>; Tue, 22 Jan 2002 17:17:11 -0500
Received: from ns.suse.de ([213.95.15.193]:36626 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289484AbSAVWRD>;
	Tue, 22 Jan 2002 17:17:03 -0500
Date: Tue, 22 Jan 2002 23:17:02 +0100
From: Andi Kleen <ak@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Message-ID: <20020122231702.A30689@wotan.suse.de>
In-Reply-To: <200201171351.g0HDpdK05456@bliss.uni-koblenz.de.suse.lists.linux.kernel> <mailman.1011289920.22682.linux-kernel2news@redhat.com> <20020122123220.A27968@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020122123220.A27968@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 12:32:20PM -0500, Pete Zaitcev wrote:
> Andi, the patch above begs two questions in my mind:
> 
> 1. Why to bind to 0 (INADDR_ANY) explicitly? My patch does not bind
> at all and expects connect() to bind automatically. It is how
> userland works and it seems to work here as well.

No real reason. Should work too. 

> 
> 2. What did you do to increase the number of unnamed devices?
> You said the patch "should" work, did that mean you did not test it?

I didn't, but the original reporter reported that it works for him.

-Andi
