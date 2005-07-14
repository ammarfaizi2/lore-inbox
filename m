Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVGNSn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVGNSn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVGNSnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:43:24 -0400
Received: from web54405.mail.yahoo.com ([68.142.225.161]:52627 "HELO
	web54405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261680AbVGNSnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:43:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e0Jt7XMR4NPtv/KF9r9zGEG51eU8IqhnHKehtAc89Z5o2DcTrY8wVj8qJjM0VJ1g57yFQbM6zWkX8jnkR2Op1/P3c0EjHJGe/7od0iG4/BmMGNGynVpEBZA9JElC2qjUzzd/Sbm7qq3ZwYOhc6Zxt/HUD/+LX8Ba7yOzfgZd6y0=  ;
Message-ID: <20050714184309.16504.qmail@web54405.mail.yahoo.com>
Date: Thu, 14 Jul 2005 11:43:09 -0700 (PDT)
From: "Vlad C." <vladc6@yahoo.com>
Subject: Re: Linux On-Demand Network Access (LODNA)
To: Peter Staubach <staubach@redhat.com>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42D5340A.7060002@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Peter Staubach <staubach@redhat.com> wrote:

> Vlad C. wrote:
> 
> >--- Hans Reiser <reiser@namesys.com> wrote:
> >  
> >
> >>Please treat at greater length how your proposal
> >>differs from NFS.
> >>    
> >>
> >
> >I think NFS is not flexible enough because:
> >
> >1) NFS requires synchronization of passwd files or
> >NIS/LDAP to authenticate users (which themselves
> >require root access on both server and client to
> >install)
> >2) NFS by definition understands only its own
> network
> >protocol.
> >3) NFS requires root privileges on the client to
> >mount. I'm not aware of a way to let normal users
> >mount an NFS partition other than listing it in the
> >client's fstab and adding the 'users' option... but
> >then changing fstab still requires root access.
> >4) Users have to contact their sysadmin every time
> >they want to mount a different partition, a
> different
> >subdirectory of the same partition, or if they want
> to
> >change the local mountpoint, all because the
> partition
> >and mountpoint are hard-coded in fstab.
> >
> >On the other hand, I envision the following:
> >
> 
> Please keep in mind that these are restrictions of
> the current NFS
> implementation and are not inherent in an NFS
> solution.
> 
> The implied need for flexibility is being addressed
> by NFSv4 and the
> ability to understand multiple versions of protocols
> and multiple
> protocols is already resident in the system.  We
> could do some work
> to make it more transparent if desired, but it
> already works.

I've used NFS but I'm by no means an expert on its
bleeding edge functionality, so my comments might have
been a bit outdated ;) From what I've seen, NFS
provides excellent network transparency, and I'm sure
version 4 is progressing nicely towards supporting
more protocols and reducing administrative overhead.

Best regards,
Vlad


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
