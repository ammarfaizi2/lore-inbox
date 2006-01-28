Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWA1Pit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWA1Pit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 10:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWA1Pis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 10:38:48 -0500
Received: from mail.enyo.de ([212.9.189.167]:11392 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751420AbWA1Pis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 10:38:48 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com>
	<20060120111103.2ee5b531@dxpl.pdx.osdl.net>
	<43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
	<43D7B20D.7040203@wolfmountaingroup.com>
	<43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>
	<D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
	<Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
	<Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
	<Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
	<43D9F9F9.5060501@ti-wmc.nl>
Date: Sat, 28 Jan 2006 16:38:43 +0100
In-Reply-To: <43D9F9F9.5060501@ti-wmc.nl> (Simon Oosthoek's message of "Fri,
	27 Jan 2006 11:46:17 +0100")
Message-ID: <87irs4qs58.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Simon Oosthoek:

> GPLv3-draft1:
>> (...)
>> Complete Corresponding Source Code also includes any encryption or
>> authorization codes necessary to install and/or execute the source
>> code of the work, perhaps modified by you, in the recommended or
>> principal context of use, such that its functioning in all
>> circumstances is identical to that of the work, except as altered by
>> your modifications. It also includes any decryption codes necessary
>> to access or unseal the work's output. Notwithstanding this, a code
>> need not be included in cases where use of the work normally implies
>> the user already has it.
>> (...)
>
> I'd interpret that as forcing people who try to hide their code or make 
> it difficult to get at the source code to not be able to do that.

I view it slightly different.  Suppose you produce a device which can
only boot images signed by a certain public key.  In this case, you
can give your users source code, but they can't change it and run it
on the device because the signature does not match.  This is a real
threat to software freedom.

Such technology already exists, see for an example:

<http://java.sun.com/products/jce/doc/guide/HowToImplAProvider.html>

The reasons for that are entirely obscure (because anyone can obtain a
certificate, there is no kind of quality control) and likely only
related to export regulations.  But a similar approach could be used
elsewhere, to exercise more control over which code can run on a
certain platform.
