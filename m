Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTFMMkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 08:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTFMMkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 08:40:32 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:53511 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S265375AbTFMMkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 08:40:31 -0400
Date: Fri, 13 Jun 2003 14:54:17 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613125417.GA90214@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <1055460564.662.339.camel@localhost> <Pine.LNX.4.44.0306121629590.11379-100000@cherise> <16105.3943.510055.309447@nanango.paulus.ozlabs.org> <1055461816.662.350.camel@localhost> <Pine.LNX.4.53.0306130823170.4004@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306130823170.4004@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 08:44:52AM -0400, Richard B. Johnson wrote:
> FYI, all memory modify operations, not using an intermediate register,
> in  32-bit mode, of a longword or less, on ix86 machines are atomic,
> even without the lock prefix.

Unless you're on SMP.  Of course 80386 SMP is not really what people
want to do, but people may compile an "universal" 386 SMP kernel and
run it on a later SMP box.

  OG.
