Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133076AbRDZWq3>; Thu, 26 Apr 2001 18:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135174AbRDZWqT>; Thu, 26 Apr 2001 18:46:19 -0400
Received: from stassen.k-net.dtu.dk ([130.225.71.227]:40893 "EHLO
	stassen.k-net.dk") by vger.kernel.org with ESMTP id <S133076AbRDZWqK>;
	Thu, 26 Apr 2001 18:46:10 -0400
Date: Fri, 27 Apr 2001 00:48:01 +0200
From: Martin Clausen <martin@ostenfeld.dk>
To: James Morris <jmorris@intercode.com.au>
Cc: netfilter-devel@lists.samba.org, linux-kernel@vger.kernel.org,
        Paul Rusty Russell <Paul.Russell@rustcorp.com.au>
Subject: Re: Kernel Oops when using the Netfilter QUEUE target
Message-ID: <20010427004801.A3464@ostenfeld.dk>
Reply-To: Martin Clausen <martin@ostenfeld.dk>
In-Reply-To: <20010425004937.A3904@ostenfeld.dk> <Pine.LNX.4.31.0104251621260.329-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104251621260.329-100000@blackbird.intercode.com.au>; from jmorris@intercode.com.au on Wed, Apr 25, 2001 at 04:24:46PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 04:24:46PM +1000, James Morris wrote:
> > I have encountered a problem (perhaps a bug)! The attached code makes my kernel oops
> > in some cases when injecting new packets through Netfilter's QUEUE target. The problem
> > only appears when the original packet is a TCP packet; i have tried with ICMP and UDP packets
> > also but this does not trigger any oops. I have tried to code on several computers and they
> > all oops. The following description regards the case when submitting new packets instead
> > of TCP packets.
> 
> Please try the patch below.

So i did and it seems to work just fine (= no more oops') under 2.4.3/2.4.2-ac21! The packets 
being sent also seems to be correct; James you're the man :-)

BTW could you describe the problem? And why it caused an oops?

Best regards,
Martin

-- 
                       There's no place like ~
