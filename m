Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTLJDiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 22:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTLJDiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 22:38:11 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:21851 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S262566AbTLJDiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 22:38:09 -0500
Message-Id: <5.1.0.14.2.20031210143503.0330f270@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 10 Dec 2003 14:38:02 +1100
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Device-mapper submission for 2.4
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031209170249.GB30286@ti19.telemetry-investments.com>
References: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
 <20031209134551.GG472@reti>
 <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:02 AM 10/12/2003, Bill Rugolsky Jr. wrote:
>On Tue, Dec 09, 2003 at 12:10:06PM -0200, Marcelo Tosatti wrote:
> > As far as I know, we already have the similar functionality in 2.4 with
> > LVM. Device mapper provides the same functionality but in a much cleaner
> > way. Is that right?
>
>Yes.
>
>And migration of root-on-LVM users to 2.6 will be *greatly* helped if users
>can get LVM2/DM working on 2.4 (by upgrading lvm/initscripts/mkinitrd),
>and then move to 2.6.

i concur with this.
Marcello: try to migrate from a root-on-LVM1/2.4 to LVM2/2.6; it is very 
painful.  major/minor # changes, more stuff required in initrd, "dm" 
doesn't appear in 2.6's /proc/partitions . . .

it is a painful upgrade - probably partly due to lack of 
tools/documentation on DMs part, but also equally because 2.4->2.6 is a bug 
jump in a kernel and its exacerbated by LVM1->LVM2 changes...


cheers,

lincoln.

