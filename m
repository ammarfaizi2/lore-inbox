Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUDBSTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 13:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbUDBSTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 13:19:09 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:22679 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S264138AbUDBSTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 13:19:05 -0500
Message-ID: <406DB0B0.8060003@am.sony.com>
Date: Fri, 02 Apr 2004 10:28:00 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Jamie Lokier <jamie@shareable.org>, Arjan van de Ven <arjanv@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, ak@muc.de,
       Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <1079453698.2255.661.camel@cube> <20040320095627.GC2803@devserv.devel.redhat.com> <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com> <20040331134009.76ca3b6d.rddunlap@osdl.org> <1080776817.2233.2326.camel@cube> <20040401155420.GB25502@mail.shareable.org> <20040401160132.GB13294@devserv.devel.redhat.com> <20040401163047.GD25502@mail.shareable.org> <406CAEB6.6080709@aurema.com> <20040402003937.GC28520@mail.shareable.org> <406CC589.8050208@aurema.com>
In-Reply-To: <406CC589.8050208@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
>> It's not possible to change USER_HZ.  There are too many programs with
>> the number hard-coded into the binary.
> 
> This is an argument that the tail should be allowed to wag the dog and 
> is not really valid :-)

It is an interesting, but untenable, position that the applications
are the tail and the OS is the dog.  The OS exists to serve the applications.
The applications, are, after all what a user actually DOES with their computer.

It is possible that the current applications which use hardcoded USER_HZ are
not important enough, or are easy enough to fix, that the cost in incompatibility
is offset by the benefit of providing different behaviour for future applications.

But breaking them for no good reason, and particularly while there is a
migration path possible over time which does not break compatibility, seems like
a bad idea.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

