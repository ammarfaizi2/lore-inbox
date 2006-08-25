Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWHYU1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWHYU1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWHYU1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:27:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65491 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932432AbWHYU1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:27:01 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sekharan@us.ibm.com
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156530108.1196.7.camel@linuxchandra>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra> <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
	 <1156417808.3007.78.camel@localhost.localdomain>
	 <1156463308.19702.40.camel@linuxchandra>
	 <FFE6D792-4D6C-4F19-A939-CBA5F0654FBA@mac.com>
	 <1156530108.1196.7.camel@linuxchandra>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 21:46:17 +0100
Message-Id: <1156538777.3007.258.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-25 am 11:21 -0700, ysgrifennodd Chandra Seetharaman:
> But, the problem is that the struct user_beancounter (part of
> wombat_controller above) is a _copy_ of the original, not the original
> itself. We cannot keep the original (in _each_ controller), as there may
> be more than one controller in the system 

Why would you want more than one controller for a given beancounter (and
thus a single measured resource). Can you give an example ?

