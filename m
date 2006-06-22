Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWFVLbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWFVLbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWFVLbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:31:49 -0400
Received: from web33304.mail.mud.yahoo.com ([68.142.206.119]:6511 "HELO
	web33304.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161077AbWFVLbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:31:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=os+5WKM0BXxfj5C/0Bz3vi51Aqasx6ufWtQWuEjuDv6SMcYgHybFVdF779Q5qjuTi0JtAmm51FQt3yF2pwPBpCJ5ccVfDOPlSFTq/7gx0iDoZV3PkdZhMtrxo+BqgzKUgK4LL8M60LUHxJ15u3t8ojtJNYbE4XSooAxCNdNL/UE=  ;
Message-ID: <20060622113147.3496.qmail@web33304.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 04:31:47 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Dropping Packets in 2.6.17
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to make a case for using linux as a
network appliance, but I can't find any
combination of settings that will keep it from
dropping packets at an unacceptably high rate.
The test system is a 1.8Ghz Opteron with intel
gigE cards running 2.6.17. I'm passing about 70K
pps through the box, which is a light load, but
userland activities (such as building a kernel)
cause it to lose packets, even with backlog set
to 20000. I had the same problem with 2.6.12 and
abandoned the effort. Has anything been done
since to give priority to networking? You can't
have a network appliance drop packets when some
application is gathering stats or a user is
looking at a graph. What tunings are available?

DT


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
