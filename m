Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272991AbTGaLD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272992AbTGaLD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:03:26 -0400
Received: from main.gmane.org ([80.91.224.249]:63164 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S272991AbTGaLDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:03:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: DMA timeouts on SIS IDE
Date: Thu, 31 Jul 2003 12:59:18 +0200
Message-ID: <yw1xbrvbgdx5.fsf@users.sourceforge.net>
References: <3F281C06.70707@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:5oXR2MWWsp8ri741EYYPiQrzuvI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton <Lionel.Bouton@inet6.fr> writes:

> the lspci output you previously sent confirmed that the SiS IDE driver
> does set the UDMA timings correctly. Given this is out of the suspects
> list, I'd advise to :
>
> - test the hardware (uneasy on a notebook, 2.5" IDE drives aren't as
> common as 3.5" ones)

As you say, testing could be tricky.  However, the machine is only
about one month old, so it shouldn't be dying already.

> - try latest ACPI on sourceforge and enable ACPI in the BIOS if not
> already done (seems to have helped once :
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104212864518052&w=4)

patch tells me those are already applied to 2.6.0-test2.  I tried
booting with pci=noacpi, just in case, but the problem remains.  I
can't find any BIOS settings relating to ACPI.

-- 
Måns Rullgård
mru@users.sf.net

