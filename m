Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135979AbRDTRBl>; Fri, 20 Apr 2001 13:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135977AbRDTRBb>; Fri, 20 Apr 2001 13:01:31 -0400
Received: from coruscant.franken.de ([193.174.159.226]:54800 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S135976AbRDTRBR>; Fri, 20 Apr 2001 13:01:17 -0400
Date: Fri, 20 Apr 2001 13:58:29 -0300
From: Harald Welte <laforge@gnumonks.org>
To: "Manfred Bartz" <md-linux-kernel@logi.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real Time Traffic Flow Measurement - anybody working on it?
Message-ID: <20010420135829.F2461@tatooine.laforge.distro.conectiva>
In-Reply-To: <20010419041557.26172.qmail@logi.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010419041557.26172.qmail@logi.cc>; from md-linux-kernel@logi.cc on Thu, Apr 19, 2001 at 02:15:56PM +1000
X-Operating-System: Linux tatooine.laforge.distro.conectiva 2.4.2-ac20
X-Date: Today is Setting Orange, the 37th day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 02:15:56PM +1000, Manfred Bartz wrote:
> Through the stimulating discussion we had under ``IP Acounting 
> Idea for 2.5'', it appears that a separate Traffic Flow Measure-
> ment and Accounting sub-system would be useful. See:
>         <http://logi.cc/linux/CounterReset/>

Hey cool. Now we've come to a point where we agree. If you want to do
serious accounting, iptables is not the subsystem of your choice.

As you've pointed out on your very enthusiastic homepage:

    * Mixing fundamentally different functionalities like security and
    * accounting in a firewall is not a good idea anyway. It leads to overly
    * complex firewall code (potentially thousands of rules just for
    * accounting) and unreliable accounting (f.e. when the firewall rules get
    * reloaded).


> I would also like to know if there are any objections to providing
> a RTFM interface in the kernel (as an optional module).

No, not at all. I'd like to help developing an RTFM meter for linux.
I guess we don't actually need to keep seperate flow information, but
could attach it to the netfilter connection tracking.

> Manfred Bartz

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
