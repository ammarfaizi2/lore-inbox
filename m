Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130780AbRBQAex>; Fri, 16 Feb 2001 19:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130759AbRBQAen>; Fri, 16 Feb 2001 19:34:43 -0500
Received: from borg.denalics.net ([209.112.170.15]:9741 "HELO
	borg.denalics.net") by vger.kernel.org with SMTP id <S130735AbRBQAe3>;
	Fri, 16 Feb 2001 19:34:29 -0500
Date: Fri, 16 Feb 2001 15:35:20 -0900 (AKST)
From: "Christopher E. Brown" <cbrown@denalics.net>
To: "Willis L. Sarka" <wlsarka@the-republic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiport NICs and ether channel?
In-Reply-To: <Pine.LNX.4.30.0102170006240.24008-100000@matrix.the-republic.org>
Message-ID: <Pine.LNX.4.10.10102161533240.13397-100000@borg.denalics.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Willis L. Sarka wrote:

> Greetings,
> 
> Just a general question or two.. Please point me to a URL or tell me where
> to RTFM, or answer back ;-).
> 
> What is the status/condition of using muliport NICs  and bonding
> them together to form a larger pipe (i.e. a quad channel ethernet card for
> an Intel box, bonding all four interfaces together to get a theoretical
> 400Mbps pipe)?  Are there any highly recommended cards of this type?  Will
> the bonding work when connected to a Cisco catalyst switch with ether
> channel?



	Linux bonding is compat with Sun EtherTrunking and Cisco
EtherChannel/FastEtherChannel.


	On the Cisco side you follow their setup examples, *except*
you *must* trun keepalives off on the cisco.  These are a Cisco
extension.  If you fail to do this the Cisco will toggle the
onterfaces *off* every 10 - 30 seconds.

 ---
        The roaches seem to have survived, but they are not routing packets
correctly.
        --About the Internet and nuclear war.


