Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVABUdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVABUdr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVABUdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:33:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3307 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261321AbVABUdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:33:43 -0500
Date: Sun, 2 Jan 2005 15:32:06 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Georg C. F. Greve" <greve@fsfeurope.org>,
       Hans Ulrich Niedermann <vserver@n-dimensional.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Herbert Poetzl <herbert@13thfloor.at>, Nick Warne <nick@linicks.net>,
       Len Brown <len.brown@intel.com>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
Message-ID: <20050102203206.GB22295@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	"Georg C. F. Greve" <greve@fsfeurope.org>,
	Hans Ulrich Niedermann <vserver@n-dimensional.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Developers <acpi-devel@lists.sourceforge.net>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Herbert Poetzl <herbert@13thfloor.at>,
	Nick Warne <nick@linicks.net>, Len Brown <len.brown@intel.com>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org> <m3zmzvl9x1.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0501021147260.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501021147260.2280@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 12:11:47PM -0800, Linus Torvalds wrote:

 > DaveJ: this may explain the "Mobile Radeon" reports. Not because of
 > anything Radeon-specific, but simply because they'd have four ports (CRT,
 > LVDS TFT panel, tv-out, and tv-in, I think - ACPI doesn't tell me enough
 > to be sure).

I think the problem biting Fedora people turned out to be a side-effect
of having the 4g/4g patch applied, but not enabled. (The affected kernels
we shipped didn't have the post-2.6.9 acpi video stuff).

		Dave

