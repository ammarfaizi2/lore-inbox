Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQKKEhw>; Fri, 10 Nov 2000 23:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQKKEhm>; Fri, 10 Nov 2000 23:37:42 -0500
Received: from c837140-a.vncvr1.wa.home.com ([65.0.81.146]:3332 "EHLO
	cyclonehq.dnsalias.net") by vger.kernel.org with ESMTP
	id <S129105AbQKKEh1>; Fri, 10 Nov 2000 23:37:27 -0500
Date: Fri, 10 Nov 2000 20:36:43 -0800 (PST)
From: Dan Browning <danb@cyclonehq.dnsalias.net>
To: willy tarreau <wtarreau@yahoo.fr>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, const-g@xpert.com,
        danb@cyclonecomputers.com
Subject: Intel's ANS Driver -vs- Bonding [was Re: Linux 2.2.18pre21]
In-Reply-To: <20001110092846.29847.qmail@web1102.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0011102032010.1963-100000@cyclonehq.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is great that there is continued valuable developement on the
bonding driver.  Have you guys taken a look at the source code for Intel's
new ANS driver?  For any Intel network card, it will do 8-way Fast
EtherChannel.  Supposedly, it also supports failover (though even
"bonding" driver docs used to say that was impossible because the linux
networking subsystem didn't handle card failures gracefully enough).  

You can check it out at:

http://support.intel.com/support/network/adapter/pro100/100Linux.htm

Maybe some of the code will help in the "bonding" driver development.  I
much prefer bonding over Intel's ANS, because bonding is GPL and works
with any net card.  Etc. etc.  

-Dan

On Fri, 10 Nov 2000, willy tarreau wrote:

> > Anything which isnt a strict bug fix or previously
> > agreed is now 2.2.19 material.
> 
> Alan, do you consider it as a bugfix if I tell you
> that
> we can't get anymore oops with the new bonding code,
> even in SMP ?
> 
> I've had reports of it working very well, and faster,
> for a long time now and the link detection seems
> completely OK now. I'd like to specially thank
> Constantine Gavrilov for all the tests he has done and
> the time he spent in enhancing the documentation.
> 
> Please find the patch against 2.2.18pre20 in
> attachment, in case you agree.
> 
> Regards,
> Willy
> 
> 
> ___________________________________________________________
> Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
> Yahoo! Messenger : http://fr.messenger.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
