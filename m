Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbTDAGvh>; Tue, 1 Apr 2003 01:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbTDAGvh>; Tue, 1 Apr 2003 01:51:37 -0500
Received: from daimi.au.dk ([130.225.16.1]:9195 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S262080AbTDAGvh>;
	Tue, 1 Apr 2003 01:51:37 -0500
Message-ID: <3E89375F.F66B225E@daimi.au.dk>
Date: Tue, 01 Apr 2003 08:53:19 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: "Paul Clements (home)" <pclements@alltel.net>,
       linux-kernel@vger.kernel.org
Subject: Re: unexporting sys_call_table a good idea?
References: <mailman.1049173681.3377.linux-kernel2news@redhat.com> <200304010606.h3166pr27274@devserv.devel.redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> Wouldn't it be easier just to add a sysctl
> which disables ptrace, instead?

I have been considering that. I'd suggest this would be more than
just a boolean. I could imagine using the lowermost bit to decide
if ptrace is allowed for root, and the next bit to decide if
ptrace is allowed for other users. But do we really want this
sysctl? When do we expect the next root exploit in ptrace?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
