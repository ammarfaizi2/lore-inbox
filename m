Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUFPSks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUFPSks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUFPSks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:40:48 -0400
Received: from ns0.cobite.com ([208.222.80.10]:2210 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id S264404AbUFPSkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:40:47 -0400
Subject: Re: 2.6.7-rc1 breaks forcedeth
From: David Mansfield <lkml@dm.cobite.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087411245.2784.2.camel@dhcp07.cobite.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 16 Jun 2004 14:40:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a 'me too' plus a fix that works for me.  Hopefully it'll
help someone else.  My symtoms were USB works, foredeth (network)
doesn't.

I have an nforce2 MB etc etc., and got everything working by:

1) recompiling kernel with UP LOCAL-APIC and IO-APIC support.
2) enabling APIC support in BIOS options.

Now it works.

David

