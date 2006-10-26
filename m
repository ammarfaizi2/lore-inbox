Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWJZIsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWJZIsp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 04:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWJZIsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 04:48:45 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:57733 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751757AbWJZIso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 04:48:44 -0400
Date: Thu, 26 Oct 2006 09:48:37 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: "Greg.Chandler@wellsfargo.com" <Greg.Chandler@wellsfargo.com>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: Touchscreen hardware hacking/driver hacking.
Message-ID: <20061026084836.GA13981@srcf.ucam.org>
References: <E8C008223DD5F64485DFBDF6D4B7F71D020C69E4@msgswbmnmsp25.wellsfargo.com> <d120d5000610251355n4104e3b8l6a86cb91a27c08eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000610251355n4104e3b8l6a86cb91a27c08eb@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 04:55:13PM -0400, Dmitry Torokhov wrote:

> It was considered but we decided that if we need to rely on solely DMI
> data when activating some features we need to add models one by one
> and do not use "blanket" options. There are lifebooks out there that
> do not have that kind of outscreen so if we tried to match just on
> "LIFEBOOK" present in the product name we might hit such models and
> then their PS/2 mice would not work.

Do the Lifebooks with these touchscreens not have a PnPBIOS or ACPI 
entry that describes the type?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
