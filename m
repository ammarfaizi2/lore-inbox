Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVCJKlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVCJKlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 05:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVCJKlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 05:41:13 -0500
Received: from web51506.mail.yahoo.com ([206.190.38.198]:58800 "HELO
	web51506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262509AbVCJKk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 05:40:56 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=I430kjkz2SqJvEgCv2yU+HutOvqFFIWqzjB04paPVdRO/JUhGFPJZ5nlynbQAbG95G9ebWs1Rrkkcb6r0JN4EFFDAjL7UMWFlT5yJ2Q/jkJOxWyi/cT6YGRz53E+IWoHeJuH/blC+rO8P2K/RDGZfXcLU5zCcUFRNZ1mSmAgrI4=  ;
Message-ID: <20050310103724.11220.qmail@web51506.mail.yahoo.com>
Date: Thu, 10 Mar 2005 02:37:24 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: [Ipsec] Issue on input process of Linux native IPsec
To: David Dillow <dave@thedillows.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 at 16:15, David Dillow wrote:
> xfrm_lookup() is only called for outgoing packets, 
> not for received packets.  I don't think ping 
> replies (ICMP echo replies) will ever have a non-
> NULL sk, as they are not associated with a socket.

But, as we know, The Linux network component creates
two special purpose sockets for use by the AF_INET
protocol family. The tcp socket is used to send resets
when a TCP packet is rejected, since there may be no
local socket corresponding to the packet. The icmp
socket is used to send ICMP messages.

Then, Why did you say that ping replies (ICMP echo
replies) were not associated with a socket? 
Is there any difference between the special purpose
socket and the socket you mentioned above?

Thank you.

Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
