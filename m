Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbTEGMXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 08:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTEGMXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 08:23:45 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:21351 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263139AbTEGMXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 08:23:41 -0400
Date: Wed, 07 May 2003 08:34:44 -0400
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: [FIXED 2.5.69] Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket
	initialisation
To: Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1052742885.e8e353@bittwiddlers.com>
Message-id: <20030507123444.GA13539@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


: It was the fact that when I booted my system with my 3com cardbus NIC inserted 
: in the slot it would oops, giving me a non-working pcmcia/cardbus system.
: 
: Booting without the card worked fine, and inserting the card afterwards also 
: worked great.
: 
: thread is here:
: 
: http://marc.theaimsgroup.com/?l=linux-kernel&m=105107713129722&w=2

Oh, mine's different.  Total lockup with no messages.  Starts a few seconds 
after the yenta module is loaded.  I think it occurs during the yenta probe
but I haven't been able to prove that yet.  

: Ah. I don't use ACPI, because well... it caused me more pain than it helped me 
: in the past, in both OS' on my system (being Linux and win2k)

Yeah, it's a pain but this laptop no longer has APM so I need some way to read
my batteries and soft power the system off.  But, if it weren't for the 
batteries I wouldn't bother because it is a real pain to deal with

-- 
  Matthew Harrell                          I love defenseless animals,
  Bit Twiddlers, Inc.                       especially in a good gravy.
  mharrell@bittwiddlers.com     
