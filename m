Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293489AbSCOXRz>; Fri, 15 Mar 2002 18:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293503AbSCOXRp>; Fri, 15 Mar 2002 18:17:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36257 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293489AbSCOXRf>;
	Fri, 15 Mar 2002 18:17:35 -0500
Date: Fri, 15 Mar 2002 15:14:46 -0800 (PST)
Message-Id: <20020315.151446.110978780.davem@redhat.com>
To: davids@webmaster.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020315231140.AAA28201@shell.webmaster.com@whenever>
In-Reply-To: <20020315.145306.15914579.davem@redhat.com>
	<20020315231140.AAA28201@shell.webmaster.com@whenever>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Schwartz <davids@webmaster.com>
   Date: Fri, 15 Mar 2002 15:11:39 -0800
   
   On Fri, 15 Mar 2002 14:53:06 -0800 (PST), David S. Miller wrote:
   >There is no reason to not be doing this MD5 garbage in
   >userspace.  Whoever thought to do this in the protocol
   >itself was smoking something.
   
   	This same argument would apply to TCP itself, wouldn't it?
   
Not at all.

   >Maybe I'm missing something, but I see no reason this MD5
   >stuff belongs in the protocol and not in the APP.
   
   	How can a TCP-using application authenticate a RST?
   
Ignoring valid RST frames is illegal.  If this RFC says to drop valid
RST frames just because the MD5 is bad, this RFC breaks TCP.

Franks a lot,
David S. Miller
davem@redhat.com
