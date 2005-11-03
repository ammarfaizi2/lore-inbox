Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbVKCS4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbVKCS4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbVKCS4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:56:11 -0500
Received: from wirelesslogix.com ([209.18.121.242]:16909 "EHLO
	mailrelay.wirelesslogixgroup.com") by vger.kernel.org with ESMTP
	id S1030436AbVKCS4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:56:10 -0500
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: New (now current development process)
Date: Thu, 3 Nov 2005 19:54:31 +0100
User-Agent: KMail/1.8
Cc: David Lang <david.lang@digitalinsight.com>, Dave Jones <davej@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Roland Dreier <rolandd@cisco.com>,
       Andrew Morton <akpm@osdl.org>, zippel@linux-m68k.org,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <Pine.LNX.4.62.0511021207550.2820@qynat.qvtvafvgr.pbz> <20051102223108.GA20416@mars.ravnborg.org>
In-Reply-To: <20051102223108.GA20416@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031954.32228.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 23:31, Sam Ravnborg wrote:
> > I used to compile with Os on all my kernels, but when the alignment
> > settings got added to the embedded section a few kernels ago and I saw
> > that they all default to 0 (no alignment) it scared me off
>
> Alignment settings in the EMBEDDED menu are ignored if set to 0, in
> other words setting alignment to 0 in Kconfig will fall back to
> compilers default values.
>
> Thats also documented in the help for the config options.

In my opinion the alignment settings are completely useless
(far too low level for a user configuration) and should be just 
removed. The per cpu or -Os defaults are totally adequate.

-Andi
