Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTIZOR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTIZOR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:17:29 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:9131 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262259AbTIZORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:17:23 -0400
Subject: Re: s390 patches: descriptions.
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF59B24CAB.2E1FA126-ONC1256DAD.004D19EA-C1256DAD.004E6EC9@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 26 Sep 2003 16:16:41 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 26/09/2003 16:17:15
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What's wrong with current zcrypt from 2.4, aside from the
> reading from urandom? It looked a relatively decent driver to me.

Reading from urandom, the ioctls are sick (linked lists in user that
are parsed by the kernel) and the timer stuff is somewhat strange
as well. Some of it has its reason in the hardware interface.
What really bothers me is
1) coding style
2) coding style
and
3) coding style.

blue skies,
   Martin


