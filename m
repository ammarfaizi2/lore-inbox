Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWDSTc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWDSTc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDSTc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:32:29 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:25512 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751099AbWDSTc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:32:28 -0400
Date: Wed, 19 Apr 2006 21:32:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tony Jones <tonyj@suse.de>
cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
In-Reply-To: <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
Message-ID: <Pine.LNX.4.61.0604192131010.7177@yvahk01.tjqt.qr>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
 <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/**
>+ * _aa_perm_dentry
[...]
>+ * Return %0 (success), +ve (mask of permissions not satisfied) or -ve (system
>+ * error, most likely -%ENOMEM).
>+ */

This was probably meant to read %-ENOMEM. (Applies anywhere else too!)



Jan Engelhardt
-- 
