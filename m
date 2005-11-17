Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVKQRtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVKQRtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVKQRtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:49:50 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:64686 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932441AbVKQRtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:49:50 -0500
Subject: Re: [patch -rt] make gendev_rel_sem a compat_semaphore
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1132243709.6744.10.camel@dhcp153.mvista.com>
References: <1132155092.6266.6.camel@localhost.localdomain>
	 <1132155299.6266.8.camel@localhost.localdomain>
	 <1132243709.6744.10.camel@dhcp153.mvista.com>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 12:49:36 -0500
Message-Id: <1132249776.10522.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 08:08 -0800, Daniel Walker wrote:
> How would you feel if we move this lock to a completion() . It's such a
> small lock, and completions are faster anyway .. It might be a good test
> bed for some other compat locks .

I feel fine with that.  Looking at the code a little, this might be a
change for mainline.

You want to do it, or do you want me?

-- Steve


