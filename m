Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTDQNb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 09:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTDQNb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 09:31:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13766
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261366AbTDQNb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 09:31:59 -0400
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mbs <mbs@mc.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Brien <admin@brien.com>,
       John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304171241.IAA08069@mc.com>
References: <200304161511.h3GFBoe7000614@81-2-122-30.bradfords.org.uk>
	 <003801c3042e$a6bcbea0$6901a8c0@athialsinp4oc1>
	 <3E9D8062.1060202@nortelnetworks.com>  <200304171241.IAA08069@mc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050583534.31390.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 13:45:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 13:46, mbs wrote:
> <not flamebait, honest question>
> you hear this all the time, but do we really have any empirical evidence 
> proving this, or is it just what we say to make ourselves feel good when 
> Linux won't run on hardware that works fine under other os's?
> </not flamebait, honest question>

Yes, both evidence and in some cases explanation. As to the reasons
quoted in the original message those are probably less true now. Linux
has extremely optimised memory copiers - our AMD memory copiers broke
older VIA chipsets, it took several months until photoshop and other
specialist apps hit the same bug with their mmx/3dnow hand tuned effects
tools on windows and VIA actually fixed it.

Linux also allocates memory in very different patterns to Windows. So
a box that shows the odd crash in windows due to a memory error may show
repeated crashes in Linux an vice versa


