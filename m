Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbRCFWHC>; Tue, 6 Mar 2001 17:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRCFWGn>; Tue, 6 Mar 2001 17:06:43 -0500
Received: from [63.95.87.168] ([63.95.87.168]:54032 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129583AbRCFWGW>;
	Tue, 6 Mar 2001 17:06:22 -0500
Date: Tue, 6 Mar 2001 17:05:51 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Bryan Rittmeyer <bryan@ixiacom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: conducting TCP sessions with non-local IPs
Message-ID: <20010306170551.D2244@xi.linuxpower.cx>
In-Reply-To: <3AA54902.AFF8550@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3AA54902.AFF8550@ixiacom.com>; from bryan@ixiacom.com on Tue, Mar 06, 2001 at 12:30:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 12:30:58PM -0800, Bryan Rittmeyer wrote:
> Hello linux-kernel,
> 
> Is there any way to conduct TCP sessions (IE have a userland process
> connect out, or accept connections) using non-local IPs? By "non-local"
> I just mean IPs that aren't assigned to an interface, but do fall into
> the network range of a running interface (so netmask, gateway, etc are
> "known").
> 
> For example, I want to bring up an interface for 10.0.0.0/255.255.255.0
> and assign it IP 10.0.0.1 Then, I want a process to accept TCP
[snip]

/sbin/ip addr add 10.2.0.0/24 dev eth0

Tada
