Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbTCaSMo>; Mon, 31 Mar 2003 13:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbTCaSMn>; Mon, 31 Mar 2003 13:12:43 -0500
Received: from gromit.aerasec.de ([195.226.187.57]:61584 "EHLO
	smtp2.aerasec.de") by vger.kernel.org with ESMTP id <S261757AbTCaSMl>;
	Mon, 31 Mar 2003 13:12:41 -0500
X-AV-Checked: Mon Mar 31 20:24:02 2003 smtp2.aerasec.de
Date: Mon, 31 Mar 2003 20:23:58 +0200
From: Peter Bieringer <pb@bieringer.de>
To: usagi-users@linux-ipv6.org, netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, ds6-devel@deepspace6.net
Subject: Re: (usagi-users 02296) IPv6 duplicate address bugfix
Message-ID: <9360000.1049135038@worker.muc.bieringer.de>
In-Reply-To: <20030330122705.GA18283@ferrara.linux.it>
References: <20030330122705.GA18283@ferrara.linux.it>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
X-URL: http://www.bieringer.de/pb/
X-OS: Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just my 2 cents, I already saw, that newest USAGI snapshot include a fix.



--On Sunday, March 30, 2003 02:27:05 PM +0200 Simone Piunno
<pioppo@ferrara.linux.it> wrote:

> When adding an IPv6 address to a given interface, I'm allowed to
> add that address multiple time, e.g.:

...

I didn't dig into any patch and also not into related drafts/RFCs, but one
scenario should be catched I think - or to be discussed:

Scenario:

Address was already added by autoconfiguration on receiving advertisement
(limited lifetime). Now the same address would be added manually (unlimited
lifetime).

What (should) happen?

Mho: manual add is allowed, both addresses need to be listed.

        Peter
-- 
Dr. Peter Bieringer                     http://www.bieringer.de/pb/
GPG/PGP Key 0x958F422D               mailto: pb at bieringer dot de 
Deep Space 6 Co-Founder and Core Member  http://www.deepspace6.net/
