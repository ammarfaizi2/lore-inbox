Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUDHLtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 07:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUDHLtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 07:49:24 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:12164 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261690AbUDHLtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 07:49:21 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: setgid - its current use
Date: Thu, 8 Apr 2004 11:49:20 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c53e80$911$2@news.cistron.nl>
References: <Pine.LNX.4.58.0404072140070.14350@d10systems.homelinux.com> <200404081041.25006.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0404072304500.14350@d10systems.homelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1081424960 9249 62.216.29.200 (8 Apr 2004 11:49:20 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0404072304500.14350@d10systems.homelinux.com>,
Dhruv Gami  <gami@d10systems.com> wrote:
>On Thu, 8 Apr 2004, Denis Vlasenko wrote:
>
>> On Thursday 08 April 2004 04:46, Dhruv Gami wrote:
>> > I'd like to know the possibility of using setgid for users to switch their
>> > groups and work as a member of a particular group. Essentially, if i want
>> > one user, who belongs to groups X, Y and Z to create a file as a member of
>> > group Y while he's logged on as a member of group X, would it be possible
>> > through setgid() ?
>> 
>> it is possible through chmod
>
>but that would be an explicit way of doing it, right ? I'm looking for 
>doing this via some system calls or something transparent to the user. At 
>most I'd like to query the user for the group as which he wants to work. 
>Which would essentially be a question I ask at login or beginning of a 
>session.

"man newgrp(1)".

Mike.

