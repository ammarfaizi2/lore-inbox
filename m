Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269352AbUHZSy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269352AbUHZSy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269347AbUHZStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:49:10 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:24763 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S269358AbUHZSmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:42:08 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.23 (Clear:RC:0(150.254.37.14):. Processed in 0.036097 secs)
Date: Thu, 26 Aug 2004 20:42:07 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) Personal
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <89370863.20040826204207@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: Reiser 4
In-Reply-To: <200408262011.29436.lkml@felipe-alfaro.com>
References: <006601c48bad$00c4b130$0700a8c0@ti10>
 <200408262011.29436.lkml@felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

FAS> On Thursday 26 August 2004 22:40, Rodrigo FGV wrote:
>> how i convert reiser3.6 to reiser4. this update is safe???

FAS> Backup / Format / Restore is the only way of migrating to Reiser4 (no magical
FAS> tool to convert from reiser3-to-reiser4 is available ATM).
Hans would be ready to write a conversion tool if you sponsor him ;-)

Anyway Hans wrote once, that future format changes in reiser4 should
be feasible by using a specially written "plugin" for that. (please
refer to the thread about plugins for details, people argue about
the terminology here)

>> the reiser4 have any critical bug?? anyone recommend this update???
Do not use it yet on important data. Please experiment though on data
you do not really value that much.

I have read a report that reiser4 has a problem with apache
trying to access .htaccess. Something about reiser4 giving a
misleading answer to a stat() call or something in that manner.

Subscribing to Reiserfs Mailinglist <reiserfs-list@namesys.com>
is also valueable of course.

There truly is a need for a glossary of terms and I belive Hans
and his crew know that the community needs proper documents
so that we all can grasp the whole idea behind reiser4 but
without so called "Hans Talk".

Regards,
Maciej


