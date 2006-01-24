Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWAXPLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWAXPLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWAXPLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:11:41 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:63374 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S964817AbWAXPLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:11:40 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17366.17322.923958.838500@gargle.gargle.HOWL>
Date: Tue, 24 Jan 2006 18:11:38 +0300
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: Michael Loftis <mloftis@wgops.com>, "Barry K. Nathan" <barryn@pobox.com>,
       Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
In-Reply-To: <728201270601240636p58fead78m781fb104c3d73da9@mail.gmail.com>
References: <200601212108.41269.a1426z@gawab.com>
	<986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	<E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	<728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
	<280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
	<17365.23510.525066.57628@gargle.gargle.HOWL>
	<728201270601240636p58fead78m781fb104c3d73da9@mail.gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Gupta writes:
 > On 1/23/06, Nikita Danilov <nikita@clusterfs.com> wrote:
 > 
 > >
 > > The unique feature that Mac OS X VM does have, on the other hand, is
 > > that it keeps profiles of access patterns of applications, and stores
 > > then in files, associated with executables. This allows to quickly
 > > pre-fault necessary pages during application startup (and this makes OSX
 > > boot so fast).
 > 
 > This feature is interesting though I am not sure about the fast boot
 > part of OSX.
 > as at boot time these applications are all started first time. So
 > there were no access pattern as yet. They still have to be demand

That's the point: information about access patterns is stored in the
file. So next time when application is started (e.g., during boot)
kernel reads that file and pre-faults pages.

 > paged. But yes later accesses may be faster.
 > 
 > Thanks
 > Ram gupta

Nikita.
