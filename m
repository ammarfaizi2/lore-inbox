Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWHISJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWHISJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWHISJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:09:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42186 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751286AbWHISJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:09:28 -0400
Message-ID: <44DA2528.5010905@sgi.com>
Date: Wed, 09 Aug 2006 20:10:48 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: How to lock current->signal->tty
References: <1155050242.5729.88.camel@localhost.localdomain> <44D8A97B.30607@linux.intel.com> <1155051876.5729.93.camel@localhost.localdomain> <20060808164127.GA11392@intel.com> <1155059405.5729.103.camel@localhost.localdomain> <yq0u04mtjni.fsf@jaguar.mkp.net> <1155120250.5729.146.camel@localhost.localdomain> <20060809162440.GA14143@intel.com>
In-Reply-To: <20060809162440.GA14143@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
> On Wed, Aug 09, 2006 at 11:44:10AM +0100, Alan Cox wrote:
>> Jes, read up on kprobes a little if you think its of no use in these
>> kind of situations. A systemtap script to count/measure alignment fault
>> rates and see who is causing the load isn't very hard to write.
> 
> But this does make sense ... the system administrator of a mainframe or
> super-computer can (and arguably should) be monitoring resource
> utilization and providing feedback to users on how to get the best
> performance from their applications.

Actually perfmon would probably be better suited for this on ia64 than
kprobes/systemtap. You can do it on hackish way with a [jk]probe, but it
isn't going to be all that pretty.

> -Tony (currently at 90% rip out this message, 10% add the mutex lock/unlock).

Nuke it!

Jes
