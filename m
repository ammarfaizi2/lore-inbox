Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTERWgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbTERWgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:36:23 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:43974 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262245AbTERWgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:36:23 -0400
Date: Sun, 18 May 2003 23:52:04 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
       kraxel@suse.de, jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030518225204.GA21068@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jamie Lokier <jamie@shareable.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
	kraxel@suse.de, jsimmons@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de> <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk> <20030518053935.GA4112@averell> <20030518161105.GA7404@mail.jlokier.co.uk> <1053290431.27107.4.camel@dhcp22.swansea.linux.org.uk> <20030518223446.GA8591@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030518223446.GA8591@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 11:34:46PM +0100, Jamie Lokier wrote:

 > If that's the problem, a test which writes a data pattern to a
 > significant chunk of video RAM in sequence, as fast as possible, and
 > then reads it would be practically guaranteed to spot this and
 > indicate that MTRRs aren't suitable for this card in this mode.

Or you could just add the PCI ID to the quirks list..

		Dave

