Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSCASrc>; Fri, 1 Mar 2002 13:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293507AbSCASrX>; Fri, 1 Mar 2002 13:47:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30727 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293505AbSCASrS>;
	Fri, 1 Mar 2002 13:47:18 -0500
Message-ID: <3C7FCC53.4E270646@zip.com.au>
Date: Fri, 01 Mar 2002 10:45:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ben Greear <greearb@candelatech.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <3C7FADBB.3A5B338F@mandrakesoft.com>,
		<3C7FADBB.3A5B338F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Mar 01, 2002 at 11:35:07AM -0500 <20020301174619.A6125@devcon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber wrote:
> 
> On Fri, Mar 01, 2002 at 11:35:07AM -0500, Jeff Garzik wrote:
> >
> > It looks like the eepro100 one, mysterious as it is, is ok.  The others
> > I have different plans for:  making them act similar to the recent
> > 8139cp changes.
> 
> The 3c59x one is available on
> 
> http://www.myipv6.de/patches/vlan/3c59x.c-8021q.patch
> 

Looks OK, except all the additions to the driver are inside

+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)

Is this avoidable somehow?

-
