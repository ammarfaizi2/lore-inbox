Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161466AbWJZWrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbWJZWrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWJZWrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:47:14 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:49340 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161456AbWJZWrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:47:13 -0400
Date: Thu, 26 Oct 2006 23:47:01 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Greg.Chandler@wellsfargo.com" <Greg.Chandler@wellsfargo.com>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: Touchscreen hardware hacking/driver hacking.
Message-ID: <20061026224701.GA19534@srcf.ucam.org>
References: <E8C008223DD5F64485DFBDF6D4B7F71D020C69E4@msgswbmnmsp25.wellsfargo.com> <d120d5000610251355n4104e3b8l6a86cb91a27c08eb@mail.gmail.com> <20061026084836.GA13981@srcf.ucam.org> <d120d5000610260929n6239772bka1a9cce971cfa133@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000610260929n6239772bka1a9cce971cfa133@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 12:29:18PM -0400, Dmitry Torokhov wrote:

> I don't recall anything in ACPI spec that would help determining type
> of PS/2 device connected, but then I did not read the latest version.
> Anyway, I would not hold my breath...

It's possible for PnP devices to have multiple identifiers associated 
with them. One of these probably identifies a PS/2 mouse device as a 
mouse device, but it's possible that there's a second identifier that 
indicates that it's something else as well.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
