Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278413AbRJMVQP>; Sat, 13 Oct 2001 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278414AbRJMVQF>; Sat, 13 Oct 2001 17:16:05 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:30341 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S278413AbRJMVPw>;
	Sat, 13 Oct 2001 17:15:52 -0400
Message-ID: <3BC8AF16.D4741B95@pobox.com>
Date: Sat, 13 Oct 2001 14:16:06 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Aaron Lehmann <aaronl@vitelus.com>,
        "peter k." <spam-goes-to-dev-null@gmx.net>,
        linux-kernel@vger.kernel.org
Subject: Re: iptables v1.2.3: can't initialize iptables table `filter': Module is 
 wrong version
In-Reply-To: <Pine.LNX.3.96.1011013160400.28071B-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> On Sat, 13 Oct 2001, Aaron Lehmann wrote:
> > On Sat, Oct 13, 2001 at 01:05:33PM +0200, peter k. wrote:
> > > iptables keeps telling me that whenever i run it although i got the latest
> > > kernel, latest iptables and all modules required for iptables are loaded (it
> > > also doesnt work when i compile them into the kernel)!
> > > anyone got an idea how to fix this?
> >
> > did you compile your iptables against the version/configuration of the
> > kernel you are trying to run?
>
> I am getting the same thing here.  I am using iptables 1.2.2 SRPMS from
> Mandrake 8.1, compiled against the latest 2.4 kernel.  Same message as
> in $subject.  I poked through the source and found that "module is wrong
> version" is the standard text message for the error code EINVAL, which
> is rather silly and uninformative.
>
> I built ipchains compatibility module, and am about to install ipchains
> and see if I can get things working that way...

Very odd - I have been running iptables since 2.3.xx.

I have never seen this error except on systems
where somebody was trying to activate iptables
rules with the ipchains module loaded...

currently using iptables 1.2.3, and have run each
kernel from 2.4.0-prerelease to 2.4.13-ac2 -

The system is Red Hat 7.1

Believe me, I'd know it in a hot second if iptables
had stopped working.

just my observations,

jjs

