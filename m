Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVBJQeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVBJQeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 11:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVBJQeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 11:34:17 -0500
Received: from relay.muni.cz ([147.251.4.35]:53123 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262169AbVBJQeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 11:34:14 -0500
Date: Thu, 10 Feb 2005 17:34:12 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: sysfs/kobject update breaks ACPI?
Message-ID: <20050210163412.GE18023@fi.muni.cz>
References: <20050210123112.GZ18023@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210123112.GZ18023@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: my laptop (Asus M6R, http://www.fi.muni.cz/~kas/m6r/) has problems with
: ACPI with newer kernels - most of ACPI operations fail
[...] 
: 	However, the patch does not touch anything related to ACPI
: (I think). It is a sysfs and kobject update. So I don't see how this
: can break ACPI for my laptop.

	Hmm, it seems to be some kind of race condition or what - with
CONFIG_ACPI_DEBUG my ACPI does not work even with 2.6.8.1 and 2.6.9,
without it it is OK up to 2.6.10-rc1-bk11. A pretty Heisenbergish
behaviour, isn't it? Works only if you do not try to debug it :-)

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
