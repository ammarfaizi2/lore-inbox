Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUHWNej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUHWNej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUHWNej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:34:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27050 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264278AbUHWNeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:34:37 -0400
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/14] kexec: apic-virtwire-on-shutdown.i386.patch
References: <m1vffd667r.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58L.0408231411480.19572@blysk.ds.pg.gda.pl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Aug 2004 07:33:08 -0600
In-Reply-To: <Pine.LNX.4.58L.0408231411480.19572@blysk.ds.pg.gda.pl>
Message-ID: <m1u0uu2d4b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@linux-mips.org> writes:

> On Fri, 20 Aug 2004, Eric W. Biederman wrote:
> 
> > Restore the local apic to virtual wire mode on reboot.
> 
>  Hmm, perhaps you should check for the through-I/O-APIC Virtual Wire mode.
> I've seen reports from such systems in the past.  They may not necessarily
> handle the through-Local-APIC mode correctly.

I do that however is done as a separate patch.

The local apic still needs to be put into virtual wire mode in that
case.


Eric

