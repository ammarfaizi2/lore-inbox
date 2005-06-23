Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVFWFJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVFWFJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVFWFJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:09:14 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:478 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262374AbVFWFJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:09:02 -0400
X-ORBL: [69.107.32.110]
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 22 Jun 2005 22:08:58 -0700
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200506222208.58494.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Andrew Morton:
> I don't have enough info to know whether the world would be a better place
> if we keep devfs, remove devfs or remove devfs even later on.  I don't
> think anyone knows, which is why we're taking this little
> disable-it-and-see-who-shouts approach.

The downside of "disable-and-remove-later" is that it becomes
too easy to just re-enable the Kconfig stuff rather than just
fixing the userspace bugs.  Expecting userspace to change at
any point before it absolutely _must_ tends to be a formula
for userspace never changing, sadly enough.  

If 2.6.13 doesn't remove devfs, when will it really go away?

- Dave



