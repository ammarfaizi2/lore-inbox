Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUHFEdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUHFEdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267712AbUHFEde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:33:34 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:23996 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S267943AbUHFEdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:33:20 -0400
Date: Fri, 6 Aug 2004 00:28:52 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: jmorris@redhat.com, mludvig@suse.cz, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH]
Message-ID: <20040806042852.GD23994@certainkey.com>
References: <20040805194914.GC23994@certainkey.com> <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com> <20040805.203623.60258238.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805.203623.60258238.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 08:36:23PM -0700, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com> (at Thu, 5 Aug 2004 22:47:12 -0400 (EDT)), James Morris <jmorris@redhat.com> says:
> 
> > > Would you be against a patch to cryptoapi to have access to a
> > > non-scatter-list set of calls?
> :
> > level.  Can you demonstrate a compelling need for raw access to the
> > algorithms via the API?
> 
> I would use them for
>  - Privacy Extensions (RFC3041) support
>  - upcoming TCP MD5 signature (RFC2385) support
> since I don't see the advantage(s) of sg for allocated memories there.

Thank you for your input.  But please read this note in the RFC2385:
http://www.faqs.org/rfcs/rfc2385.html
 "Section 4.4: MD5 as a Hashing Algorithm"
 It talks about MD5 as an insecure algorithm and how changing it would
 require a new RFC, which make me sad.
 If you could add support for SHA-1 as well that would be nifty.
 
James,
  Back to your question:
    I want to replace the legacy MD5 and the incorrectly implemented SHA-1
    implementations from driver/char/random.c

Thanks, cheers!

JLC
