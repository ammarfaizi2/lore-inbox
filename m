Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314022AbSDKLA3>; Thu, 11 Apr 2002 07:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314023AbSDKLA2>; Thu, 11 Apr 2002 07:00:28 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:477 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S314022AbSDKLA1>; Thu, 11 Apr 2002 07:00:27 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Shirley <dave@cs.curtin.edu.au>
Date: Thu, 11 Apr 2002 21:03:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15541.28044.720063.458160@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The process of NFS mounting?
In-Reply-To: message from David Shirley on Thursday April 11
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday April 11, dave@cs.curtin.edu.au wrote:
> Hi everyone,
> 
> I'm not sure that this is the correct list for this question,
> so I apologise if you think so.

nfs@lists.sourceforge.net might be a reasonable alternative.

> 
> Basically I want to understand the process of NFS mounting
> in terms of network activity and transactions from client
> to server.

use ethereal to watch what actually happens on the wire...

> 
>  From my understanding basically the client requests the mountd
> port from the servers portmapper.
> 
> Then the client talks to mountd
> 
> etc etc etc..
> 
> Well the problem I have is that it seems that mountd is trying to
> establish a new UDP connection (yeah yeah i know...) to the mount
				            ^^^^^^^ Not sure what you know...
> client process. Is this what is supposed to happen?
> 

Maybe if you try to explain your difficulty more clearly we might be
able to help.  Try explaining exactly what you think happens and
exactly why you doubt that that is correct..

You may well find yourself answering your own qujestion :-)

NeilBrown
