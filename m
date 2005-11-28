Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVK1ElF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVK1ElF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 23:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVK1ElE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 23:41:04 -0500
Received: from xenotime.net ([66.160.160.81]:4271 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751234AbVK1ElC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 23:41:02 -0500
Date: Sun, 27 Nov 2005 20:41:32 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: vherva@vianova.fi
Cc: bunk@stusta.de, folkert@vanheusden.com, linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
Message-Id: <20051127204132.2b0d7406.rdunlap@xenotime.net>
In-Reply-To: <20051126193358.GF22255@vianova.fi>
References: <20051122130754.GL32512@vanheusden.com>
	<20051126155656.GA3988@stusta.de>
	<20051126193358.GF22255@vianova.fi>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2005 21:33:58 +0200 Ville Herva wrote:

> On Sat, Nov 26, 2005 at 04:56:56PM +0100, you [Adrian Bunk] wrote:
> > On Tue, Nov 22, 2005 at 02:07:54PM +0100, Folkert van Heusden wrote:
> > 
> > > Hi,
> > 
> > Hi Folkert,
> > 
> > > My 2.6.14 system occasionally crashes; gives a kernel panic. Of course I
> > > would like to report it. Now the system locks up hard so I can't copy
> > > the stacktrace. The crash dump patches mentioned in oops-tracing.txt all
> > > don't work for 2.6.14 it seems. So: what should I do? Get my digicam and
> > > take a picture of the display?
> > 
> > yes, digicams have become a common tool for reporting Oops'es.
> 
> Speaking of which, does anybody know a feasible (as in "not too much harder
> than manually typing it in manually") way to OCR characters from vga text
> mode screen captures - or even digican shots? 
> 
> The vga text mode captures are from a remote administration interface (such
> as HP RILOE or vmware gsx console) so they are pixel perfect and OCR should
> be doable. The digican shots on the other hand... Well at least it would
> have hack value :).
> 
> (My personal opinion is that Linus' unwillingness to include anything like
> kmsgdump (http://www.xenotime.net/linux/kmsgdump/) is somewhat unfortunate.)

BTW, status of that:  it needs a little work to be more reliable.
(It hangs sometimes when switching from protected to real mode.)
I'm hoping that some of the APIC/IOAPIC/PIC patches that are being
done for kdump will also help kmsgdump.  I'll be working more on it
in the next few weeks/months.

so yes, when it's working, it's very useful IMO.

---
~Randy
