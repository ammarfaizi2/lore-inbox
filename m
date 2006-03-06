Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWCFPUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWCFPUf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCFPUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:20:35 -0500
Received: from fmr17.intel.com ([134.134.136.16]:55249 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750750AbWCFPUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:20:34 -0500
Message-ID: <440C53A1.2050706@linux.intel.com>
Date: Mon, 06 Mar 2006 09:22:09 -0600
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060129
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Rompf <stefan@loplof.de>
CC: Andrew Morton <akpm@osdl.org>, Benoit Boissinot <bboissin@gmail.com>,
       linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Zhu Yi <yi.zhu@intel.com>
Subject: Re: 2.6.16-rc5-mm2
References: <20060303045651.1f3b55ec.akpm@osdl.org> <20060305081442.GH29560@ens-lyon.fr> <20060305003457.48478db0.akpm@osdl.org> <200603051242.20503.stefan@loplof.de>
In-Reply-To: <200603051242.20503.stefan@loplof.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Rompf wrote:

>Hi,
>
>Am Sonntag 05 März 2006 09:34 schrieb Andrew Morton:
>
>  
>
>>That check was changed from
>>
>>	"If this STA doesn't use WPA and that AP does, then bale"
>>
>>into
>>
>>	"If this STA does use WPA and that AP doesn't then bale".
>>
>>So a theory would be that your AP isn't filling in those WPA length fields.
>>I see no reason why we should permit that to disable WEP?
>>    
>>
>
>problem is that wpa_supplicant needs to set wpa_enabled unconditionally, so 
>with this  change it hasn't been possible to connect to non-WPA networks 
>using WPA supplicant. For the discussion on the IPW list, see 
>http://marc.theaimsgroup.com/?t=114004412300002&r=1&w=2 .
>
>1.0.12 fixes this by removing the check entirely. James: Does it makes sense 
>for you to push 1.1.0 out to netdev soon, or better just the fix for this?
>  
>
We'll gather up all the patches that have accumulated out of tree that
are not already in John's tree and get them sent to netdev today.

Thanks,
James

