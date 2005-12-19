Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVLSRqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVLSRqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVLSRql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:46:41 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:11226 "EHLO mailbox.ines.ro")
	by vger.kernel.org with ESMTP id S932316AbVLSRql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:46:41 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
In-Reply-To: <A3567036-A5F9-4CF9-BC48-70CFEAA8F2C4@comcast.net>
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
	 <20051216140425.GY23349@stusta.de>
	 <20051216163503.289d491e.diegocg@gmail.com>
	 <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
	 <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de>
	 <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net>
	 <20051218054323.GF23384@wotan.suse.de>
	 <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net>
	 <43A694DF.8040209@aitel.hist.no>
	 <A3567036-A5F9-4CF9-BC48-70CFEAA8F2C4@comcast.net>
Content-Type: text/plain; charset=utf-8
Organization: iNES Group
Date: Mon, 19 Dec 2005 19:43:21 +0200
Message-Id: <1135014201.10933.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.2 (2.5.2-1) 
Content-Transfer-Encoding: 8bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 1.6.2 on MailBox.iNES.RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

În data de Lu, 19-12-2005 la 11:22 -0500, Parag Warudkar a scris:
> Whoever benefits can use the 4K stacks, others who feel it risky to  
> have 4K stacks for whatever reason, can be happy too. We can even  
> make the 4K default, but having supported option of 8K is important  
> and almost all operating systems are having >4K stacks on i386  
> machines, so there is some reason for having it.

Sloppy coding ? As long you don't have the source you can't be sure.
Point to an open source (and not tainting by just reading it) code which
uses >4k+IRQstack stacks.

Millions of flyes eat shit.
It must be a reason for having it...

-- 
Cioby


