Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTDUSLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTDUSLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:11:38 -0400
Received: from fmr01.intel.com ([192.55.52.18]:49600 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261832AbTDUSLf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:11:35 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263699@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Greg KH'" <greg@kroah.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
Date: Mon, 21 Apr 2003 11:23:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Greg KH [mailto:greg@kroah.com]
> 
> > Yep, that is the point, and it is small enough (5 ulongs) that
> > it can be embedded anywhere without being of high impact and
> > having to allocate it [first example that comes to mind is
> > for sending a device connection message; you can embed a short
> > message in the device structure and query that for delivery;
> > no buffer, no nothing, the data straight from the source].
> 
> And the device is removed from the system, the memory for that device is
> freed, and then a user comes along and trys to read that message.
> 
> oops...  :)

Hey! Come on! You don't think I am that lame, do you? Man what
a fame I do have!

Before the device vaporizes, it recalls the message, so there is 
no message to read - the same way you take away the sysfs data from
the sysfs tree ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
