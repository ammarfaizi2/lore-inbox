Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132709AbRAZAwe>; Thu, 25 Jan 2001 19:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRAZAwZ>; Thu, 25 Jan 2001 19:52:25 -0500
Received: from gatekeeper.gozer.weebeastie.net ([61.8.7.91]:27652 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S136039AbRAZAwO>; Thu, 25 Jan 2001 19:52:14 -0500
Date: Fri, 26 Jan 2001 11:50:57 +1100
From: CaT <cat@zip.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
Message-ID: <20010126115057.A366@zip.com.au>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net> <200101251905.f0PJ5ZG216578@saturn.cs.uml.edu> <14960.31423.938042.486045@pizda.ninka.net> <20010125115214.D9992@draco.foogod.com> <m3itn3i5iu.fsf@austin.jhcloos.com> <14960.50897.494908.316057@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14960.50897.494908.316057@pizda.ninka.net>; from davem@redhat.com on Thu, Jan 25, 2001 at 04:37:37PM -0800
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 04:37:37PM -0800, David S. Miller wrote:
> 
> James H. Cloos Jr. writes:
>  > Are there any well know sites using ECN we can test against?
> 
> Use non-passive FTP to my workstation and just do a directory listing
> which will make the FTP server create a TCP connection back to your
> machine for the transfer of the directory listing.
> 
> My workstation is pizda.ninka.net, please everyone be nice.

*screatches head*

I'm not sure as to what the problem with hotmail may be. I have ECN
turned on:

gozer:~# more /proc/sys/net/ipv4/tcp_ecn 
1

and I can contact hotmail just fine. I also can ftp to your site
non-passively. where should I go to on hotmail to see it fail?

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
