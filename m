Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVAXN31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVAXN31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVAXN31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:29:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52922 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261437AbVAXN3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:29:22 -0500
Date: Mon, 24 Jan 2005 13:29:18 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Keith Owens <kaos@sgi.com>
Cc: Christian Hildner <christian.hildner@hob.de>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: optimize __gp location
Message-ID: <20050124132918.GH31455@parcelfarce.linux.theplanet.co.uk>
References: <41F4A8F5.3020207@hob.de> <9120.1106572936@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9120.1106572936@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 12:22:16AM +1100, Keith Owens wrote:
> Unfortunately marking jiffies and similar small but high usage
> variables as section .sbss or .sdata requires changes to common code.
> It might be worth doing, but the change would have to be structured so
> it worked on all architectures.

I think there are other architectures which would prefer
small-and-frequently-used global variables to be placed somewhere special,
so there may well be wide-spread enthusiasm for such an annotation.

CC'ing linux-kernel to see if anyone bites.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
