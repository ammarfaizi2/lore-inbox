Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTGHHKS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 03:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTGHHKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 03:10:18 -0400
Received: from holomorphy.com ([66.224.33.161]:56480 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264039AbTGHHKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 03:10:16 -0400
Date: Tue, 8 Jul 2003 00:26:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Thomas Schlichter <schlicht@uni-mannheim.de>, smiler@lanil.mine.nu,
       KML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Message-ID: <20030708072604.GF15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Schlemmer <azarah@gentoo.org>, Andrew Morton <akpm@osdl.org>,
	Thomas Schlichter <schlicht@uni-mannheim.de>, smiler@lanil.mine.nu,
	KML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu> <200307071734.01575.schlicht@uni-mannheim.de> <20030707123012.47238055.akpm@osdl.org> <1057647818.5489.385.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057647818.5489.385.camel@workshop.saharacpt.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 09:03:39AM +0200, Martin Schlemmer wrote:
> Bit too specific to -mm2, what about the the attached?

Well, it'd also help to check whether this is a userspace address or
a kernelspace address. Kernelspace access would only require
pmd_offset_kernel().

Where are these nvidia and vmware patches, anyway? I can maintain
fixups for highpmd for the things and it would at least help me a
bit to see what's going on around the specific areas.


-- wli
