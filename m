Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUDNOMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUDNOMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:12:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44769 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264229AbUDNOMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:12:50 -0400
Date: Wed, 14 Apr 2004 15:12:45 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage, 2nd try  [0/3]
Message-ID: <20040414141245.GC18329@parcelfarce.linux.theplanet.co.uk>
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <20040413215833.A7047@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413215833.A7047@Marvin.DL8BCU.ampr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 09:58:33PM +0000, Thorsten Kranzkowski wrote:
> Arch maintainers please have a look whether I got the constants right or
> if your architecture has a PIC or speaker at all.

parisc certainly doesn't.  i'd start by making this change for alpha,
x86 and x86_64 and make the PC speaker depend on (ALPHA || X86 || X86_64)
then other arches can take it from there if they want to supoprt the
pc speaker.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
