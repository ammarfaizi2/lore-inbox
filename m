Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbTCUApn>; Thu, 20 Mar 2003 19:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbTCUApn>; Thu, 20 Mar 2003 19:45:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27111 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262704AbTCUApl>;
	Thu, 20 Mar 2003 19:45:41 -0500
Message-ID: <3E7A635C.3090000@pobox.com>
Date: Thu, 20 Mar 2003 19:57:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jay Vosburgh <fubar@us.ibm.com>
CC: "David S. Miller" <davem@redhat.com>, hshmulik@intel.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [Bonding-devel] [patch] (2/8) Add 802.3ad support to bonding
 (released to bonding on sourceforge)
References: <OF1BD71312.6E4C42DC-ON88256CF0.000314A8@us.ibm.com>
In-Reply-To: <OF1BD71312.6E4C42DC-ON88256CF0.000314A8@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Vosburgh wrote:
>       Fair enough; the delay has gotten excessive of late.
> 
>       Would it be satisfactory going forward for the sourceforge site to
> contain patches to "standard" releases (e.g., 2.4.20), and do updates to
> the current development kernel and the sourceforge site simultaneously? In
> other words, sourceforge has a patch containing all bonding updates since
> 2.4.20 (or whichever version) was released, and each time that patch is
> updated, the incremental update goes out for inclusion in the development
> kernel.


The ideal situation is for you to send two sets of patches, one for 2.4 
tree and one for 2.5 tree.  Those will get applied to 2.4.21-pre and 
2.5.<latest>.  Patches against 2.4.20 proper are ok as long as they 
apply correctly to the latest 2.4.21-pre tree (so, patches against 
2.4.21-pre are preferred)

If the patches are the same for 2.4 and 2.5, just send one set and note 
that fact.  My preference would be to address these patches

	To: davem@redhat.com
	CC: netdev@oss.sgi.com, jgarzik@pobox.com

(David, feel free to correct me here, or direct patches to me)

When you receive bug fixes, forwarding ASAP would be very much appreciated.

	Jeff



