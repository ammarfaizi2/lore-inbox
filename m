Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWFVAXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWFVAXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWFVAXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:23:34 -0400
Received: from web33315.mail.mud.yahoo.com ([68.142.206.130]:32397 "HELO
	web33315.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932134AbWFVAXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:23:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=z3BOROTZD+ETu3gkVcoqjKd1tAAESDZmNc0VdGuC4NCoyRxFeNMTchsUapED1oh2dXwltFU8vKsvqtl5ngRHtTbT7N/vzIZf/w7kWhkZ5Yqvr4WMuHmNxccYi0F8l9X+zqYdIEmQqVbstKZIorf6TE7T50HLZUizm68FN2cBULM=  ;
Message-ID: <20060622002332.32800.qmail@web33315.mail.mud.yahoo.com>
Date: Wed, 21 Jun 2006 17:23:32 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: syscall trace in messages
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
