Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTEPVhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 17:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTEPVhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 17:37:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54183
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262709AbTEPVhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 17:37:53 -0400
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Andi Kleen <ak@muc.de>, kraxel@suse.de, jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030515151633.GA6128@suse.de>
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 21:51:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-15 at 16:16, Dave Jones wrote:
> There are PCI ET4000's too.  Though if we can get the PCI IDs for those,
> we can work around them with a quirk.  I have one *somewhere*, but it'll
> take me a while to dig it out.

Some older SiS cards have problems too. I have a 6326 that doesn't work
with sisfb (too old) and vesafb with mtrr fails.

