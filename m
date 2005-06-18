Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVFRRQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVFRRQX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 13:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVFRRQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 13:16:23 -0400
Received: from web52909.mail.yahoo.com ([206.190.39.186]:39828 "HELO
	web52909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262158AbVFRRQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 13:16:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RFc/756J4/mtEJv+/Gc97CMPXk3jJcm7SXR99FEQI6ZOLmpzU1Kc1/VHUUcT/JtsF5ctVL3tYelSIVYCDJ9MEuLJMp270xaYMV2CTPuy5cNMnLPLRl9WCWOEJWQk9xeWJgrGG+OsDbjy5D4TlMLGnNARRXX5CaCpKm77IO9kj1s=  ;
Message-ID: <20050618171615.66470.qmail@web52909.mail.yahoo.com>
Date: Sat, 18 Jun 2005 18:16:15 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: 2.6.12: connection tracking broken?
To: Tobias DiPasquale <codeslinger@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
In-Reply-To: <876ef97a05061808141d503f58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Tobias DiPasquale <codeslinger@gmail.com> wrote:
> Did you have /proc/sys/net/ipv4/ip_forward turned on?

Yes, because otherwise it wouldn't work in 2.6.11.11 either. My userspace environment is identical
between 2.6.12 an 2.6.11.11, but the RELATED and ESTABLISHED packets aren't forwarded across the
bridge in 2.6.12.

And no, I haven't tried recompiling my userspace iptables tools. Why would this make any
difference? "iptables -L -v" reports exactly what I expect to see.

Cheers,
Chris



		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
