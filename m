Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTIYRpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbTIYRoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:44:05 -0400
Received: from fmr09.intel.com ([192.52.57.35]:2244 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261718AbTIYRnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:43:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Shmulik Hen <shmulik.hen@intel.com>
Reply-To: shmulik.hen@intel.com
Organization: Intel corp.
To: Jay Vosburgh <fubar@us.ibm.com>
Subject: Re: [Bonding-announce] [PATCH SET][bonding] cleanup
Date: Thu, 25 Sep 2003 20:43:40 +0300
User-Agent: KMail/1.4.3
Cc: "Chad N. Tindel" <chad@tindel.net>, bonding-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "Noam, Amir" <amir.noam@intel.com>,
       "Mendelson, Tsippy" <tsippy.mendelson@intel.com>,
       "Noam, Marom" <noam.marom@intel.com>
References: <200309251733.h8PHXWpV013559@death.ibm.com>
In-Reply-To: <200309251733.h8PHXWpV013559@death.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309252043.40608.shmulik.hen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 September 2003 08:33 pm, Jay Vosburgh wrote:
>
> 	Separately, recent ifenslaves have compatibility code within
> them to cover the great "ifenslave calling sequence change" from
> April or so.  As much as I love the sleek new slimmed down
> ifenslave, I'm not absolutely sure we can nuke that compatibility
> stuff within ifenslave.  I really, really wanna, but I'm not sure
> if it will cause problems for end users.  This is the upgrade
> scenario that prompted the creation of the whole "ABI version" and
> compat stuff in the first place; if we don't have to worry about
> that, then the simpler ifenslave can be used, and I think the
> ethtool ABI version hack can go away (since we wouldn't need an ABI
> version if there's only one).
>
> 	Comments?
>

I think I better leave this for Amir to answer. He's our ABI expert 
and this needs carefull consideration, especially now that he's 
working on enhancing ifenslave's capabilities for the hot operation 
stuff. However, he won't be able to do that before Monday since we're 
going out on a long weekend - it's holiday season over here.

-- 
| Shmulik Hen   Advanced Network Services  |
| Israel Design Center, Jerusalem          |
| LAN Access Division, Platform Networking |
| Intel Communications Group, Intel corp.  |

