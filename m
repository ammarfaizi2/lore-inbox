Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVFRMoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVFRMoH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 08:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVFRMoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 08:44:06 -0400
Received: from web52901.mail.yahoo.com ([206.190.39.178]:27273 "HELO
	web52901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262105AbVFRMoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 08:44:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5TpbLgYou4elfho4otatv6ve/e56DTG8fpbELqJmE1alp4/EWn6w/eZx2ZNoBnsZ3J86uYfI41aIesJnTKkEP9Q1bbq23HPXH4KvTTyPnWJ6mLD9hXWp5YdqVEZni3d+JcienOBqppWfOvdz2+0RR+TCIhRTD1DFsbhOi1wDHC8=  ;
Message-ID: <20050618124359.39052.qmail@web52901.mail.yahoo.com>
Date: Sat, 18 Jun 2005 13:43:59 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: 2.6.12: connection tracking broken?
To: netfilter-devel@lists.netfilter.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just tried upgrading my firewall to 2.6.12, but neither of the following rules in my
FORWARD table was allowing return traffic:

 1109  814K ACCEPT     all  --  ppp0   br0     anywhere             anywhere         ctstate
RELATED,ESTABLISHED
  11M   13G ACCEPT     all  --  ppp0   br0     anywhere             anywhere         state
RELATED,ESTABLISHED

I have currently returned to using 2.6.11.11, where the identical configuration works fine. br0 is
a bridge device containing two e100 devices, and ppp0 is my PPPoE DSL link. I am using iptables
1.3.1.

Cheers,
Chris



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
