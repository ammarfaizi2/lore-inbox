Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966236AbWKNTA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966236AbWKNTA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966261AbWKNTA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:00:57 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:62221
	"HELO linuxace.com") by vger.kernel.org with SMTP id S966236AbWKNTA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:00:56 -0500
Date: Tue, 14 Nov 2006 11:00:56 -0800
From: Phil Oester <kernel@linuxace.com>
To: Oleg Verych <olecom@flower.upol.cz>, sam@ravnborg.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: make menuconfig regression in 2.6.19-rc
Message-ID: <20061114190056.GA22951@linuxace.com>
References: <20061114003752.GA15295@linuxace.com> <E1GjtT7-0002to-LO@flower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GjtT7-0002to-LO@flower>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 08:16:33AM +0000, Oleg Verych wrote:
> Phil Oester wrote:
> > In commit 350b5b76384e77bcc58217f00455fdbec5cac594, the default menuconfig
> > color scheme was changed to bluetitle.  This breaks the highlighting
> > of the selected item for me with TERM=vt100.  The only way I can see
> > which item is selected is via:
> >
> >     make MENUCONFIG_COLOR=mono menuconfig
> >
> > Which restores the pre-2.6.19 white on black highlighting.  
> 
> Classic theme also doesn't work, and this commit doesn't look like
> changing anything in it.
> 
> Thus, i think, just export variable with working theme (mono) on your
> exotic setup.

Hmm...vt100 is exotic?  If only you'd told me that 20 years ago ;-)

> > Sam?
> 
> If you want answer from busy developers, try to add their e-mail next
> time.

Thanks for the tip.

Phil
