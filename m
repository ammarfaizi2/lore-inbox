Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbTIPPaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTIPPaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:30:39 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:14062 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261943AbTIPPag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:30:36 -0400
Date: Tue, 16 Sep 2003 08:29:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <1555500000.1063726166@[10.10.2.4]>
In-Reply-To: <20030916153658.3081af6c.skraw@ithnet.com>
References: <20030916102113.0f00d7e9.skraw@ithnet.com><Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Oh... Jens just pointed bounce buffering is needed for the upper 2Gs. 
>> 
>> Maybe you have a SCSI card+disks to test ? 8)
> 
> Well, I do understand the bounce buffer problem, but honestly the current way
> of handling the situation seems questionable at least. If you ever tried such a
> system you notice it is a lot worse than just dumping the additional ram above
> 4GB. You can really watch your network connections go bogus which is just
> unacceptable. Is there any thinkable way to ommit the bounce buffers and still
> do something useful with the beyond-4GB ram parts?
> We should not leave the current bad situation as is...

It won't need to bounce buffer if you have a decent driver & hardware.

M.

