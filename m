Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUC0XzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUC0XzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:55:18 -0500
Received: from alt.aurema.com ([203.217.18.57]:46248 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261931AbUC0XzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:55:14 -0500
Message-ID: <406613BC.90602@aurema.com>
Date: Sun, 28 Mar 2004 09:52:28 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Micha Feigin <michf@post.tau.ac.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com> <20040322223456.GB2549@luna.mooo.com> <405F70F6.5050605@aurema.com> <20040325174053.GB11236@mail.shareable.org> <406369A1.7090905@aurema.com> <20040327133133.GB21884@mail.shareable.org>
In-Reply-To: <20040327133133.GB21884@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Peter Williams wrote:
> 
>>Making HZ == USER_HZ would also solve the problem.
> 
> 
> They were equal once.
> 
> Making them equal now would reintroduce the problem that USER_HZ was
> created to resolve: some userspace programs hard-code the value, so it
> cannot be changed in interfaces used by those programs.

That was the wrong solution to that particular problem.  The programs 
should have been fixed rather than the kernel being maimed to 
accommodate their shortcomings.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

