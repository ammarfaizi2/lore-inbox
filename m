Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVJENvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVJENvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 09:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbVJENvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 09:51:48 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:28811 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S965175AbVJENvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 09:51:47 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17219.55937.27499.495968@gargle.gargle.HOWL>
Date: Wed, 5 Oct 2005 17:52:01 +0400
To: Marc Perkel <marc@perkel.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <4343D367.5030608@perkel.com>
References: <20051002204703.GG6290@lkcl.net>
	<4342DC4D.8090908@perkel.com>
	<200510050122.39307.dhazelton@enter.net>
	<4343694F.5000709@perkel.com>
	<17219.39868.493728.141642@gargle.gargle.HOWL>
	<4343D367.5030608@perkel.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel writes:
 > 

[...]

 > Now of you think "outside" the Linux box" you can see where people in 
 > the real world would expect that if you have no rights to a file to read 
 > or write to it that you shouldn't be able to delete it. In the outside 
 > world it's "duh - of course"! but for thouse that are in the "Unix Cult" 
 > you can't think past inodes.

Deleting files without read/write access to them is exactly what happens
in the real world of classified information: people who physically burn
paper folders have no right to open them. :-)

Please understand one simple thing: unlink(2) system call does not
_remove_ file. It just removes one of possibly many references to this
file from an index. To erase (a part of) a file body, one uses
truncate(2) system call that --wonders!-- requires write access to the
file.

[...]

 > 
 > Once you'be had Netware permissions - even 1990 Netware permission - you 
 > are spoiled and everything else isn't even close.
 > 

Repeating "sugar" doesn't make it sweet.

Nikita.
