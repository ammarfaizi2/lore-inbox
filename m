Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTCDWCu>; Tue, 4 Mar 2003 17:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTCDWCu>; Tue, 4 Mar 2003 17:02:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:47781 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261427AbTCDWCt>;
	Tue, 4 Mar 2003 17:02:49 -0500
Date: Tue, 4 Mar 2003 14:09:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Mark Wong <markw@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.63-mm2
Message-Id: <20030304140918.4092f09b.akpm@digeo.com>
In-Reply-To: <1046815078.12931.79.camel@ibm-b>
References: <20030302180959.3c9c437a.akpm@digeo.com>
	<1046815078.12931.79.camel@ibm-b>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2003 22:13:12.0501 (UTC) FILETIME=[3F06BE50:01C2E29B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Wong <markw@osdl.org> wrote:
>
> It appears something is conflicting with the old Adapatec AIC7xxx.  My
> system halts when it attempts to probe the devices (I think it's that.) 
> So I started using the new AIC7xxx driver and all is well.  I don't see
> any messages to the console that points to any causes.  Is there
> someplace I can look for a clue to the problem?
> 
> I actually didn't realize I was using the old driver and have no qualms
> about not using it, but if it'll help someone else, I can help gather
> information.

There are "fixes" in that driver in Linus's tree.  I suggest you revert to
the 2.5.63 version of aic7xxx_old.c, see if that fixes it.

