Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVCOQuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVCOQuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVCOQuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:50:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20948 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261451AbVCOQuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:50:09 -0500
Date: Tue, 15 Mar 2005 16:50:03 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [PATCH] 2.6.11-mm3 patch for ext3 writeback "nobh" option
Message-ID: <20050315165003.GF21986@parcelfarce.linux.theplanet.co.uk>
References: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com> <20050314180917.07f7ac58.akpm@osdl.org> <1110902996.24286.328.camel@dyn318077bld.beaverton.ibm.com> <1110903996.6290.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110903996.6290.73.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 05:26:36PM +0100, Arjan van de Ven wrote:
> I still don't get why you want a mount option. Sure during development
> it can be nice.. but do you still want it in the production trees??
> (I understand that for small blocksizes you need to fallback code, fine,
> no problem, but why do you want to make it an *option* instead of
> automatic)

Can we get rid of the "nobh" ext2 mount option too so other people don't
get mislead into thinking this is a good idea?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
