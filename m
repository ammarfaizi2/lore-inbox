Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUHMNVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUHMNVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUHMNVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:21:25 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:15074 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S265250AbUHMNVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:21:22 -0400
Date: Fri, 13 Aug 2004 09:15:33 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux-kernel@vger.kernel.org
Subject: [jlcooke@certainkey.com: Re: SHA-0]
Message-ID: <20040813131533.GI2192@certainkey.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--B4IIlcmfBL/1gGOG
Content-Type: message/rfc822
Content-Disposition: inline

Date: Fri, 13 Aug 2004 09:13:50 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: lkml@vger.kernel.org
Subject: Re: SHA-0
Message-ID: <20040813131350.GH2192@certainkey.com>
References: <Xine.LNX.4.44.0408122311240.20474-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408122311240.20474-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040523i

No it does not...we think...

SHA-0 is the nick-name for the first draft of SHA put forward by NIST/NSA of
the US Gov't.  Cryptographers got up in arms about how it had a "lazy bit" (a
bit that does not effect the output of the hash) and how it did not have
enough rounds.

So, they named the "first" SHA SHA-0 because it wasn't good enough.  And
SHA-1 the "first released" SHA.  SHA-1 was designed to be stronger than
SHA-0 in at least one of the ways SHA-0 was recently exploited.

Still, this is a very interesting development in the field of hash function
cryptanalysis.  Biham should be co-presenting a paper explain how they did
it soon.  They give allusion to a possible attack on SHA-1...but I hear it's
still theoretical.

SHA-256 is looking better.  Though SHA-1 is still strong enough, it may not
last to its 2012 "expiry date" for vulnerabilities to collision attacks set
by Lenstra/Verheul in (1).

Cheers,

JLC

(1) Selecting Cryptographic Key Sizes</a> by Arjen K. Lenstra, Eric R. Verheul
    <http://www.cacr.math.uwaterloo.ca/conferences/1999/ecc99/lenstra.doc>

On Thu, Aug 12, 2004 at 11:12:03PM -0400, James Morris wrote:
> Hi Jean-Luc,
> 
> I read on sci.crypt about the SHA-0 collision, do you know if this casts 
> doubt on SHA-1?
> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
> 

--B4IIlcmfBL/1gGOG--
