Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVAMWSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVAMWSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVAMWNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:13:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23960 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261763AbVAMV4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:56:50 -0500
Subject: Re: [PATCH] release_pcibus_dev() crash
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1105651078.30960.33.camel@sinatra.austin.ibm.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com>
	 <1105638551.30960.16.camel@sinatra.austin.ibm.com>
	 <20050113181850.GA24952@kroah.com>
	 <200501131021.19434.jbarnes@engr.sgi.com>
	 <20050113183729.GA25049@kroah.com>
	 <1105647135.30960.22.camel@sinatra.austin.ibm.com>
	 <20050113202532.GA30780@kroah.com>
	 <1105649679.30960.27.camel@sinatra.austin.ibm.com>
	 <20050113210501.GA31402@kroah.com>
	 <1105651078.30960.33.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1105653339.30960.37.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:55:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just to be a brat, I'll point out that I couldn't find a single user of
> CLASS_DEVICE_ATTR that explicitly cleans things up like we're doing here.  That
> would include firmware and net-sysfs stuff.  Maybe enforcing such a policy upon
> device removal would increase participation :)  But okay, here's another try:

Well, okay, I found three drivers that do.  But most don't! :)  </rant> 

John

