Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131670AbRBAXUP>; Thu, 1 Feb 2001 18:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131951AbRBAXUF>; Thu, 1 Feb 2001 18:20:05 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:22792
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S131670AbRBAXTy>; Thu, 1 Feb 2001 18:19:54 -0500
Date: Thu, 1 Feb 2001 18:19:52 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Re: What does "NAT: dropping untracked packet" mean?
Message-ID: <20010201181952.A5803@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
In-Reply-To: <20010201133811.D14768@ipe.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Newsgroups: local.linux.kernel
In-Reply-To: <20010201151717.D5706@emma1.emma.line.org>
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010201151717.D5706@emma1.emma.line.org> you write:
> On Thu, 01 Feb 2001, Nils Rennebarth wrote:
> > Feb  1 12:58:56 obelix kernel: NAT: 0 dropping untracked packet
> ce767600 1 129.69.22.21 -> 224.0.0.2
> 
> It means that your box drops multicast administrative packets on the
> floor.

I'm getting the occasional

Feb  1 13:17:08 yendi kernel: NAT: 0 dropping untracked packet
c3ea4da0 1 146.188.249.73 -> 209.220.232.240

syslog message.  What exactly does it mean?  146.188.249.73 isn't my
machine at all, and 209.220.232.240 is my firewall.  I assume I'm
dropping someone's packets on the floor, but what can cause a packet
to get dropped like that?

-- 
Dave Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
