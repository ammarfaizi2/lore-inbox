Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269893AbUJSUPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269893AbUJSUPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 16:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269900AbUJSUP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 16:15:29 -0400
Received: from smtp.terra.es ([213.4.129.129]:39233 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S269773AbUJSUO4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:14:56 -0400
Date: Tue, 19 Oct 2004 22:14:57 +0200
From: Diego Calleja <diegocg@teleline.es>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.9 and GPL Buyout
Message-Id: <20041019221457.3ad7dbea.diegocg@teleline.es>
In-Reply-To: <4175657E.7040800@drdos.com>
References: <Pine.LNX.4.44.0410191530060.18723-100000@chimarrao.boston.redhat.com>
	<4175657E.7040800@drdos.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 19 Oct 2004 13:05:34 -0600 "Jeff V. Merkey" <jmerkey@drdos.com> escribió:


> You're awesome. We don't use XFS, JFS, or SMP for our appliances so 
> these changes
> have little impact for us.

Just wondering, how did you remove RCU? From a quick grep it's used in generic
code like fs/dcache.c or kernel/sched.c. Did you remove process scheduler and
filesystem support for your customers too? Or I'm missing something about RCU?
