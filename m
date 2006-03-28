Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWC1XH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWC1XH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWC1XH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:07:28 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52365 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S964816AbWC1XHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:07:25 -0500
Subject: Re: [RFC] Virtualization steps
From: Sam Vilain <sam@vilain.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
In-Reply-To: <44294B33.3040507@tmr.com>
References: <44242A3F.1010307@sw.ru>  <44242D4D.40702@yahoo.com.au>
	 <1143228339.19152.91.camel@localhost.localdomain>
	 <4428BB5C.3060803@tmr.com> <4428FB2B.8070805@sw.ru>
	 <44294B33.3040507@tmr.com>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 11:07:38 +1200
Message-Id: <1143587258.6325.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 09:41 -0500, Bill Davidsen wrote:
> > It is more than realistic. Hosting companies run more than 100 VPSs in 
> > reality. There are also other usefull scenarios. For example, I know 
> > the universities which run VPS for every faculty web site, for every 
> > department, mail server and so on. Why do you think they want to run 
> > only 5VMs on one machine? Much more! 
> 
> I made no commont on what "they" might want, I want to make the rack of 
> underutilized Windows, BSD and Solaris servers go away. An approach 
> which doesn't support unmodified guest installs doesn't solve any of my 
> current problems. I didn't say it was in any way not useful, just not of 
> interest to me. What needs I have for Linux environments are answered by 
> jails and/or UML.

We are talking about adding jail technology, also known as containers on
Solaris and vserver/openvz on Linux, to the mainline kernel.

So, you are obviously interested!

Because of course, you can take an unmodified filesystem of the guest
and assuming the kernels are compatible run them without changes.  I
find this consolidation approach indispensible.

Sam.

