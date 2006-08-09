Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030688AbWHIL0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030688AbWHIL0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWHIL0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:26:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45730 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030688AbWHIL0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:26:50 -0400
Message-ID: <44D9C670.5060609@sgi.com>
Date: Wed, 09 Aug 2006 13:26:40 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: How to lock current->signal->tty
References: <1155050242.5729.88.camel@localhost.localdomain>	 <44D8A97B.30607@linux.intel.com>	 <1155051876.5729.93.camel@localhost.localdomain>	 <20060808164127.GA11392@intel.com>	 <1155059405.5729.103.camel@localhost.localdomain>	 <yq0u04mtjni.fsf@jaguar.mkp.net> <1155120250.5729.146.camel@localhost.localdomain>
In-Reply-To: <1155120250.5729.146.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-08-09 am 04:09 -0400, ysgrifennodd Jes Sorensen:
>> Personally I don't like the current approach. However, I believe the
>> philosophy behind it is that users rarely look in dmesg and they
>> should be notified (and beaten with a stick) when their badly written
>> app spawns unaligned accesses which end up being emulated by the
>> kernel.
> 
> The users won't seem the anyway, they are hidden behind the GUI.

Regularly see complaints from users in the HPC space over this .....
clearly it's the kernel thats broken, not their buggy code.

Jes
