Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWBHH66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWBHH66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWBHH66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:58:58 -0500
Received: from ns.suse.de ([195.135.220.2]:33472 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161068AbWBHH66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:58:58 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Date: Wed, 8 Feb 2006 08:55:05 +0100
User-Agent: KMail/1.8.2
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
       linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <200602080110.06736.ak@suse.de> <20060208030335.GC17665@redhat.com>
In-Reply-To: <20060208030335.GC17665@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080855.06000.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 04:03, Dave Jones wrote:

>  > Workaround is pci=nommconf btw
> 
> I'm puzzled.  I'm still seeing this crash with latest -git which
> has this patch (I just double checked the source I built).

That's surprising. Can you addr2line the exactly address it's crashing on?

-Andi
