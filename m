Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278401AbRJSNYm>; Fri, 19 Oct 2001 09:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278402AbRJSNYc>; Fri, 19 Oct 2001 09:24:32 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:61965 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S278401AbRJSNYQ>;
	Fri, 19 Oct 2001 09:24:16 -0400
Message-ID: <20011019173233.A12919@castle.nmd.msu.ru>
Date: Fri, 19 Oct 2001 17:32:33 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org,
        Christopher Friesen <cfriesen@nortelnetworks.com>
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
In-Reply-To: <3BCF2A44.60B295FD@nortelnetworks.com> <200110181925.XAA04814@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <200110181925.XAA04814@ms2.inr.ac.ru>; from "A.N.Kuznetsov" on Thu, Oct 18, 2001 at 11:25:42PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey,

On Thu, Oct 18, 2001 at 11:25:42PM +0400, A.N.Kuznetsov wrote:
> 
> > I (and others) have asked this a couple times here and on the netdev list, and
> > so far nobody has answered it (not even negatively).
> 
> :-) And me answered to this hundred of times: "no way". :-)
> 
> Ability to add/delete them with "ip neigh" will be removed in the next
> snapshot as well. The feature is obsolete.

Well, in solutions I ship to customers I need to use some proxy-arp features.
I don't want to turn on proxy arp on an interface basis, because subtle
mistakes in network configuration with proxy arp turned on may have serious
consequences, including arp storm (sic!), and people, especially those called
customers, do make mistakes.
So far, the solution has been to manually create proxy arp entries, that are
known to be safe.

Are you opposing the idea of proxy arp entries being created not by an
automatic discovery (arp on other interface)?
Or you just want to cripple `ip'? :-)

	Andrey
