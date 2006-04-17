Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWDQVRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWDQVRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWDQVRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:17:55 -0400
Received: from [81.2.110.250] ([81.2.110.250]:18103 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751301AbWDQVRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:17:54 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060417195146.GA8875@kroah.com>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072138.35201.edwin@gurde.com>
	 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
	 <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Apr 2006 22:26:24 +0100
Message-Id: <1145309184.14497.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-17 at 12:51 -0700, Greg KH wrote:
> I agree about the BSD secure levels code, it has a known reported
> security problem, with no response by its maintainers.  On that aspect
> alone, it should be removed.

You can implement a BSD securelevel model in SELinux as far as I can see
from looking at it, and do it better than the code today, so its not
really a feature drop anyway just a migration away from some fossils

