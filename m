Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285450AbRLGTHE>; Fri, 7 Dec 2001 14:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285440AbRLGTGy>; Fri, 7 Dec 2001 14:06:54 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2775 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S285438AbRLGTGt>;
	Fri, 7 Dec 2001 14:06:49 -0500
Date: Fri, 07 Dec 2001 11:06:01 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>
cc: Henning Schmiedehausen <hps@intermeta.de>, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <2700813795.1007723161@mbligh.des.sequent.com>
In-Reply-To: <20011207104830.N27589@work.bitmover.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're right, it's so much better to manage all machines independently
> so that they can get out of sync with each other.

No it's much better to just have one machine running one instance of
the OS so that it can't get out of sync with itself.
 
>> Keeping things simple that users and/or sysadmins have to deal with is a 
>> Good Thing (tm). I'd have the complexity in the kernel, where complexity 
>> is pushed to the kernel developers, thanks.
> 
> Yeah, that's what I want, my password file management in the kernel.  
> Brilliant.  Why didn't I think of that?

No, I want my password file management to be in a one file for the whole
machine. Where it is now. Without requiring syncronisation. If we put the 
complexity in the kernel to make the system scale running one OS we 
don't have the problem that you're creating at all.
 
>> No it's not that far off topic, my point is that you're shifting the complexity 
>> problems to other areas (eg. system mangement / the application level / 
>> filesystems / scheduler load balancing) rather than solving them.
> 
> Whoops, you are so right, in order to work on OS scaling I'd better solve
> password file management or the OS ideas are meaningless.  Uh huh.  I'll
> get right on that, thanks for setting me straight here.

If you don't chop the OS up into multiple instances, you don't have these
problems. If you create the problems, I expect you to solve them. 

You're not making the system as a whole scale, you're just pushing the
problems out somewhere else.

Martin.

