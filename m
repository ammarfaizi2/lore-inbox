Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWBUR6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWBUR6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWBUR6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:58:18 -0500
Received: from [81.2.110.250] ([81.2.110.250]:14546 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932339AbWBUR6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:58:17 -0500
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor
	attributes to sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <43FB2642.7020109@us.ibm.com>
References: <43FB2642.7020109@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Feb 2006 18:02:03 +0000
Message-Id: <1140544923.840.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last time I checked sizeof(char) was 1 so the kcalloc sizeof(char) is
excessive and we als have kzalloc() which would be slightly cleaner.
Otherwise looks sane to me

Alan



