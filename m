Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWBHRYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWBHRYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWBHRYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:24:20 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35976 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030354AbWBHRYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:24:19 -0500
Subject: Re: libata PATA status report on 2.6.16-rc1-mm5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43EA11F5.4000205@bootc.net>
References: <33D367D1-870E-46AE-A7EC-C938B51E816F@bootc.net>
	 <1139400278.26270.10.camel@localhost.localdomain>
	 <43E9F41C.30204@bootc.net>  <43EA11F5.4000205@bootc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Feb 2006 17:26:29 +0000
Message-Id: <1139419590.27721.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-08 at 15:44 +0000, Chris Boot wrote:
> My next step will be to play with the CD drive. Any hints on 
> stress-testing the drive? Obviously writing a CD then comparing to the 
> ISO will be one step, but any others?

The PATA specific code is almost entirely in the setup stages. Once the
setup is done then (with the exception of early PIIX devices, radisys,
triflex and a couple of other oddities) there is no "new" code actually
being run.

Alan

