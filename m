Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUD3Lsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUD3Lsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 07:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUD3Lsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 07:48:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:42507 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265161AbUD3Lsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 07:48:36 -0400
Message-ID: <40923D65.2010704@aitel.hist.no>
Date: Fri, 30 Apr 2004 13:49:57 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Paul Wagland <paul@wagland.net>, Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>,
       Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com>
In-Reply-To: <4091757B.3090209@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> 
> While we're on all of this, are we going to change "tained" to some 
> other less alarmist word?  Say there is a /proc file or some report that 
> you can generate about the kernel that simply wants to indicate that the 
> kernel contains closed-source modules, and we want to use a short, 
> concise word like "tainted" for this.  "An untrusted module has been 
> loaded into this kernel" would be just a bit too long to qualify.
> 
> Hmmm... how about "untrusted"?  Not sure...

"Unsupported" seems a good candidate to me.  It describes the
situation fairly well.  Such a kernel is unsupported by the
kernel community, and probably by the binary module vendor
too. They tend to restrict support to their own module . . .

Helge Hafting

