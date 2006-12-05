Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030726AbWLETxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030726AbWLETxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030735AbWLETxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:53:16 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:54629 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030726AbWLETxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:53:16 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4575CE1F.4030508@s5r6.in-berlin.de>
Date: Tue, 05 Dec 2006 20:53:03 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205184921.GA5029@martell.zuzino.mipt.ru>
In-Reply-To: <20061205184921.GA5029@martell.zuzino.mipt.ru>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Tue, Dec 05, 2006 at 12:22:29AM -0500, Kristian Høgsberg wrote:
>> I'm announcing an alternative firewire stack that I've been working on
>> the last few weeks.
> 
> Is mainline firewire so hopeless, that you've decided to rewrite it?
> Could you show some ugly places in it?

Although that's for Kristian to answer (and much of the answer can
already be found in his posting), here are some ugly things.
http://bugzilla.kernel.org/buglist.cgi?product=Drivers&component=IEEE1394&bug_status=NEW&bug_status=ASSIGNED&bug_status=NEEDINFO
Or look here first: http://bugzilla.kernel.org/show_bug.cgi?id=6070

There have been severe issues with the FireWire drivers during a certain
period, due to lack of care. That's partly a thing of the past, and I
definitely don't consider the mainline drivers hopeless. (Otherwise I
hadn't stepped in as maintainer.) But we still lack manpower for
bugfixing. Also, the bugs which are left now are the ones that are the
hardest to find and fix. Therefore I am glad that Kristian is back again
and is contributing some real work. (For those who don't know him, he
has worked on the drivers in the past, long before I did.)

> We can end up with two not quite working sets of firewire drivers your
> way.

As long as I will be interested in maintenance of the FireWire drivers,
I intend to help that either a successful switch to the new stack is put
into practice, or that Kristian's designs and implementation are copied
where they benefit the old stack. I'm not sure which way it will go; it
depends on (1) who contributes what and (2) the shape in which
mainline's FireWire stack will be in in 2007. Right now it lacks modularity.
-- 
Stefan Richter
-=====-=-==- ==-- --=-=
http://arcgraph.de/sr/
