Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280941AbRKGTmh>; Wed, 7 Nov 2001 14:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280939AbRKGTm3>; Wed, 7 Nov 2001 14:42:29 -0500
Received: from pop.digitalme.com ([193.97.97.75]:6169 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S280941AbRKGTmK>;
	Wed, 7 Nov 2001 14:42:10 -0500
Subject: Re: ip_conntrack & timing out of connections
From: "Trever L. Adams" <vichu@digitalme.com>
To: kuznet@ms2.inr.ac.ru
Cc: David Lang <david.lang@digitalinsight.COM>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111071855.VAA07803@ms2.inr.ac.ru>
In-Reply-To: <200111071855.VAA07803@ms2.inr.ac.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0+cvs.2001.11.06.15.04 (Preview Release)
Date: 07 Nov 2001 14:41:36 -0500
Message-Id: <1005162108.1222.1.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-07 at 13:55, kuznet@ms2.inr.ac.ru wrote:
> > > From: pcg@goof.com
> ...
> > > linux-2.4.13-ac5 (other versions untested) has this peculiar behaviour: If I
> > > "killall -STOP thttpd", I, of course, still get connection requests which
> > > usually time out:
> > >
> > > tcp      238      0 217.227.148.85:80       213.76.191.129:3120 CLOSE_WAIT
> 
> Blatant lie. Such connections cannot timeout. If they do, kernel really
> have fatal bug.
> 

Then the kernel (iptables or what not) has a huge fatal bug.  I have
seen this happen as well.  The firewall then catches all of these 'ACK
FIN' etc.  This is getting more rare for me and usually takes a moderate
to heavy load (for link capacity) before it starts happening, but it
does happen.

Trever


