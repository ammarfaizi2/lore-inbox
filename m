Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUHaKlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUHaKlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267791AbUHaKlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:41:32 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:17900 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267765AbUHaKlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:41:19 -0400
Date: Tue, 31 Aug 2004 11:40:46 +0100
From: Dave Jones <davej@redhat.com>
To: Raphael Jacquot <raphael.jacquot@imag.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: VIA AGPGart problem
Message-ID: <20040831104046.GB22978@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Raphael Jacquot <raphael.jacquot@imag.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <41343B29.4080508@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41343B29.4080508@imag.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 10:47:37AM +0200, Raphael Jacquot wrote:

 > with agp enabled
 > run Xorg with the via driver -> X dies after a couple of seconds
 > run Xorg with frame buffer -> X dies after a minute or so
 > 
 > with agp disabled
 > run Xorg with the via driver -> X dies after a couple minutes

This line pretty much absolves agpgart of blame as far as I'm concerned.
I've tested agpgart on a lot of VIA chipsets quite heavily which means
I'm more inclined to believe you have a problem with the Xorg driver.

btw, unless you've patched in and enabled VIA DRI in your kernel,
agpgart shouldn't even be getting used.

		Dave

