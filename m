Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129837AbRCGBrx>; Tue, 6 Mar 2001 20:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRCGBrn>; Tue, 6 Mar 2001 20:47:43 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23307
	"EHLO gateway.matchmail.com") by vger.kernel.org with ESMTP
	id <S129837AbRCGBra>; Tue, 6 Mar 2001 20:47:30 -0500
Message-ID: <3AA592FF.5107E508@matchmail.com>
Date: Tue, 06 Mar 2001 17:46:39 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregory Maxwell <greg@linuxpower.cx>
CC: Bryan Rittmeyer <bryan@ixiacom.com>, linux-kernel@vger.kernel.org
Subject: Re: conducting TCP sessions with non-local IPs
In-Reply-To: <3AA54902.AFF8550@ixiacom.com> <20010306170551.D2244@xi.linuxpower.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:
> 
> On Tue, Mar 06, 2001 at 12:30:58PM -0800, Bryan Rittmeyer wrote:
> > Hello linux-kernel,
> >
> > Is there any way to conduct TCP sessions (IE have a userland process
> > connect out, or accept connections) using non-local IPs? By "non-local"
> > I just mean IPs that aren't assigned to an interface, but do fall into
> > the network range of a running interface (so netmask, gateway, etc are
> > "known").
> >
> > For example, I want to bring up an interface for 10.0.0.0/255.255.255.0
> > and assign it IP 10.0.0.1 Then, I want a process to accept TCP
> [snip]
> 
> /sbin/ip addr add 10.2.0.0/24 dev eth0
> 
> Tada
How would you deal with the other computer responding to the host "port not
reachable"?
