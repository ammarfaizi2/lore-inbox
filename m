Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTCDWz6>; Tue, 4 Mar 2003 17:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbTCDWz6>; Tue, 4 Mar 2003 17:55:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3538 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265570AbTCDWz5>;
	Tue, 4 Mar 2003 17:55:57 -0500
Subject: Re: 2.5.63-mm2
From: Mark Wong <markw@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030304140918.4092f09b.akpm@digeo.com>
References: <20030302180959.3c9c437a.akpm@digeo.com>
	<1046815078.12931.79.camel@ibm-b>  <20030304140918.4092f09b.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Mar 2003 15:06:24 -0800
Message-Id: <1046819184.12936.100.camel@ibm-b>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 14:09, Andrew Morton wrote:
> Mark Wong <markw@osdl.org> wrote:
> >
> > It appears something is conflicting with the old Adapatec AIC7xxx.  My
> > system halts when it attempts to probe the devices (I think it's that.) 
> > So I started using the new AIC7xxx driver and all is well.  I don't see
> > any messages to the console that points to any causes.  Is there
> > someplace I can look for a clue to the problem?
> > 
> > I actually didn't realize I was using the old driver and have no qualms
> > about not using it, but if it'll help someone else, I can help gather
> > information.
> 
> There are "fixes" in that driver in Linus's tree.  I suggest you revert to
> the 2.5.63 version of aic7xxx_old.c, see if that fixes it.

Reverting to Linus's 2.5.63 tree produces the same problem for me.  I
had thought I tried it before, but it turns out I was running 2.5.62. 
2.5.62's aic7xxx_old is good for me.

