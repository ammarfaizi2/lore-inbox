Return-Path: <linux-kernel-owner+w=401wt.eu-S1751874AbXARIZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbXARIZx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 03:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXARIZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 03:25:53 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35344 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbXARIZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 03:25:52 -0500
Subject: Re: [PATCH] Fix missing include of list.h in sysfs.h
From: Frank Haverkamp <haver@vnet.ibm.com>
Reply-To: haver@vnet.ibm.com
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Frank Haverkamp <haver@vnet.ibm.com>
In-Reply-To: <20070117211447.GA32495@kroah.com>
References: <1169052679.21717.9.camel@localhost.localdomain>
	 <20070117211447.GA32495@kroah.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 18 Jan 2007 09:25:45 +0100
Message-Id: <1169108745.4231.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 2007-01-17 at 13:14 -0800, Greg KH wrote:

> Does this currently cause a build error on any platform for 2.6.20-rc5?

Not that I know of. I saw it because a friend of mine tried to port
some old code and played with the include ordering. Somehow he got
a compile error doing it, and we found that it is strange that sysfs.h
is using structs from list.h but is not including it. As result I sent
the patch to propose that it gets included to avoid any possible
trouble.

Frank

