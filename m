Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTJJRU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTJJRU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:20:26 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:1934 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S263069AbTJJRUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:20:25 -0400
Date: Fri, 10 Oct 2003 10:20:02 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010172001.GA29301@ca-server1.us.oracle.com>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	Jamie Lokier <jamie@shareable.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031010122755.GC22908@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org> <20031010152710.GA28773@ca-server1.us.oracle.com> <20031010160144.GI28795@mail.shareable.org> <20031010163300.GC28773@ca-server1.us.oracle.com> <3F86E51D.3090605@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F86E51D.3090605@nortelnetworks.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 12:58:05PM -0400, Chris Friesen wrote:
> >	Because you can't force flush/read.  You can't say "I need you
> >to go to disk for this."
> 
> According to my man pages, this is exactly what msync() is for, no?

	msync() forces write(), like fsync().  It doesn't force read().

Joel

-- 

"Get right to the heart of matters.
 It's the heart that matters more."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
