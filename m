Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278411AbRJMVGZ>; Sat, 13 Oct 2001 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278412AbRJMVGG>; Sat, 13 Oct 2001 17:06:06 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:43824 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278411AbRJMVFz>; Sat, 13 Oct 2001 17:05:55 -0400
Date: Sat, 13 Oct 2001 16:06:18 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: "peter k." <spam-goes-to-dev-null@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: iptables v1.2.3: can't initialize iptables table `filter': Module is wrong version
In-Reply-To: <20011013135507.B9856@vitelus.com>
Message-ID: <Pine.LNX.3.96.1011013160400.28071B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Aaron Lehmann wrote:
> On Sat, Oct 13, 2001 at 01:05:33PM +0200, peter k. wrote:
> > iptables keeps telling me that whenever i run it although i got the latest
> > kernel, latest iptables and all modules required for iptables are loaded (it
> > also doesnt work when i compile them into the kernel)!
> > anyone got an idea how to fix this?
> 
> did you compile your iptables against the version/configuration of the
> kernel you are trying to run?

I am getting the same thing here.  I am using iptables 1.2.2 SRPMS from
Mandrake 8.1, compiled against the latest 2.4 kernel.  Same message as
in $subject.  I poked through the source and found that "module is wrong
version" is the standard text message for the error code EINVAL, which
is rather silly and uninformative.

I built ipchains compatibility module, and am about to install ipchains
and see if I can get things working that way...

	Jeff




