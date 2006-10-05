Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWJEVld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWJEVld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWJEVld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:41:33 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:29618 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932235AbWJEVlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:41:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=FyD5+XHE9Rl4ItZunPeUvJLL2VeQUobSolmnXUdN6whj3jQ4bq8iE4Err2u8dHhtWlsnxq1Yu+vJqAMflZeRgtG+MPQXiNgqQpIVU8fvaaxVdI/lM3TapIyqRDxM6WYBq8JKmwGb2xxIWeC1WzyN0ifRtGfBBm+bvySIak8rxHY=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 00/14] UML: simple changes for 2.6.19
Date: Thu, 05 Oct 2006 23:32:12 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first set of patches for UML for 2.6.19 I send - I have various
other patches to merge but I'm sending them in separate batches to avoid
flooding.

This first batch consists of:
* compilation/linking correction to merged patches (both from Jeff and from me)
in different configurations (including fixing up Pcap and crypto-modules
compilation)
* some longly needed changes to Kconfig entries (deprecate TT mode, update some
comments, add HOST_VMSPLIT config option to match host's VMSPLIT option).

--
Paolo 'Blaisorblade' Giarrusso
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
