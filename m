Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbTGDIkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbTGDIkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:40:06 -0400
Received: from holomorphy.com ([66.224.33.161]:39884 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265891AbTGDIim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:38:42 -0400
Date: Fri, 4 Jul 2003 01:53:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704085300.GY26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F054109.2050100@aitel.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 10:55:37AM +0200, Helge Hafting wrote:
> 2.5.74-mm1 dies very early during bootup due to some APIC trouble:
> (written down by hand)
> Posix conformance testing by UNIFIX
> enabled Extint on cpu #0
> ESR before enabling vector 00000000
> ESR after enabling vector 00000000
> Enabling IP-APIC IRQs
> BIOS bug, IO-APIC #0 ID2 is already used!...
> kernel panic: Max APIC ID exceeded!

Okay, fixing.


-- wli
