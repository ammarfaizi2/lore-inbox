Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSKOEMk>; Thu, 14 Nov 2002 23:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbSKOEMk>; Thu, 14 Nov 2002 23:12:40 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:14858
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265791AbSKOEMk>; Thu, 14 Nov 2002 23:12:40 -0500
Date: Thu, 14 Nov 2002 23:12:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Corey Minyard <cminyard@mvista.com>
cc: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: NMI handling rework
In-Reply-To: <3DD46DF1.50500@mvista.com>
Message-ID: <Pine.LNX.4.44.0211142311160.2750-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Corey Minyard wrote:

> I haven't received much feedback on getting this included into the 
> kernel.  I think it's a good idea since the nmi handler was starting to 
> get messy, especially when you add kdb, NMI watchdogs, etc.

What protects the handler list from traversal in NMI context whilst we 
update the list?

	Zwane
-- 
function.linuxpower.ca

