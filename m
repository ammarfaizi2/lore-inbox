Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbRD0J4H>; Fri, 27 Apr 2001 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135354AbRD0Jz5>; Fri, 27 Apr 2001 05:55:57 -0400
Received: from p3EE3CBF4.dip.t-dialin.net ([62.227.203.244]:36868 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135318AbRD0Jzv>; Fri, 27 Apr 2001 05:55:51 -0400
Date: Fri, 27 Apr 2001 11:55:48 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre7 build failure w/ IP NAT and ipchains
Message-ID: <20010427115548.A16249@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010427025315.A25473@burns.dt.e-technik.uni-dortmund.de> <15081.10132.61529.136589@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15081.10132.61529.136589@pizda.ninka.net>; from davem@redhat.com on Fri, Apr 27, 2001 at 01:02:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, David S. Miller wrote:

> Your configuration seems impossible, somehow the config system allowed
> you to set CONFIG_IP_NF_COMPAT_IPCHAINS without setting
> CONFIG_IP_NF_CONNTRACK.

Wow.

Now, if I set "connection tracking" to "y", the ipchains option
disappears (make menuconfig). Are things supposed to behave this way?
I'd like to stick to ipchains for a while, rather than switch to
iptables. (Administrator laziness, of course.)
