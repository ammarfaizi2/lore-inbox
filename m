Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318590AbSGZWaj>; Fri, 26 Jul 2002 18:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318591AbSGZWaj>; Fri, 26 Jul 2002 18:30:39 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:60818 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318590AbSGZWah>;
	Fri, 26 Jul 2002 18:30:37 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 26 Jul 2002 16:26:45 -0600
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
Message-ID: <20020726162645.N13656@host110.fsmlabs.com>
References: <20020726143345.E13656@host110.fsmlabs.com> <20020726233339.D21176@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020726233339.D21176@suse.de>; from davej@suse.de on Fri, Jul 26, 2002 at 11:33:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you check to make sure for me?  If you stick a 'wall my power changed $*'
into /etc/apmd_proxy or /etc/sysconfig/apm-scripts/scripts (or where-ever
SuSE puts it) then pull the power from your Vaio what does it give you?  I
can get the 'apm' commant to tell me the power state (same with the gnome
applets) but apmd is never asynchronously notified.

I'm trying to find which versions/models do this so I can properly
characterize the check agains the DMI data.

} But not all Vaio's. My z600 (which is what they sold the z505 series as in .eu)
} for example behaves correctly when I plug in/pull out the power cord
} repeatedly.
} 
} We might be better off special casing 'known bad' models in the
} DMI blacklist instead of assuming carte blanche that all vaio's are bad.
} Might even come down to a specific BIOS version that's at fault.
} 
}         Dave
} 
} -- 
} | Dave Jones.        http://www.codemonkey.org.uk
} | SuSE Labs
