Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVHEUFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVHEUFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVHEUFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:05:53 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:23698 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263108AbVHEUFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:05:17 -0400
Subject: Re: [patch] fsnotify: hook on removexattr, too
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: marijn ros <marijn@mad.scientist.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1123271715.30486.82.camel@betsy>
References: <20050805180739.A49DF1F50B1@ws1-2.us4.outblaze.com>
	 <1123271715.30486.82.camel@betsy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 16:05:16 -0400
Message-Id: <1123272316.28473.0.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 15:55 -0400, Robert Love wrote:
> On Fri, 2005-08-05 at 19:07 +0100, marijn ros wrote:
> 
> > I got wondering, why does fs_notify_xattr get called from setxattr in fs/xattr.c, but
> > not from removexattr that is below it in the same file? Both seem to make changes to
> > xattrs and both are exported as system calls.
> 
> We should.
> 

Yes we should.

Signed-off-by: John McCtuchan <ttb@tentacle.dhs.org>

-- 
John McCutchan <ttb@tentacle.dhs.org>
