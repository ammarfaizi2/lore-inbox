Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUG1Vpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUG1Vpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUG1Vpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:45:55 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:226 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S264685AbUG1Vpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:45:51 -0400
Message-ID: <41081E8B.7030607@candelatech.com>
Date: Wed, 28 Jul 2004 14:45:47 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@redhat.com>, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040728124256.GA31246@devserv.devel.redhat.com> <20040728143634.0931ee07.akpm@osdl.org>
In-Reply-To: <20040728143634.0931ee07.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Alan Cox <alan@redhat.com> wrote:
> 
>>This adds VLAN support to the 3c59x/90x series hardware.
> 
> 
> Sigh.  This has been floating about for ever.  My reluctance stemmed
> from largely-theoretical-sounding objections from Don Becker which I
> didn't fully understand at the time and have now forgotten.
> 
> Ben, does the patch look complete/correct to you?

I don't have such hardware, but I don't see any obvious problems
with the patch.

In my opinion Becker's complaints were invalid, or maybe I just
didn't understand what he was trying to say.  At any rate, lots of
other NICs have supported larger MTUs and VLANs w/out problem, so
it is unlikely that there is a fundamental flaw in accepting larger
frames.

There are patches for tulip floating around too.  I have been running
traffic on these patches for a while with no obvious problems
(on 2.4 kernel, however).  Jeff, if you want me to re-send this to you,
please let me know!

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

