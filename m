Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVBOTaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVBOTaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVBOTaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:30:52 -0500
Received: from mail.gmx.de ([213.165.64.20]:8102 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261815AbVBOTao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:30:44 -0500
X-Authenticated: #14776911
From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger@gmx.at>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 20:37:59 +0100
User-Agent: KMail/1.7.2
Cc: Norbert Preining <preining@logic.at>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
In-Reply-To: <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502152038.00401.stefandoesinger@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 15. Februar 2005 18:08 schrieb Norbert Preining:
> On Die, 15 Feb 2005, Carl-Daniel Hailfinger wrote:
> > To suspend and resume properly, call the following script as root:
>
> Success.
>
> After deactivating DRI in the X config file and saving the states with
> your script (thanks) and turning off various stuff I get X running
> again.
>
> Questions:
> - DRI must be disabled I guess?! Even with newer X server (x.org)?
Do you use the fglrx driver? This doesn't work with any type of suspend so 
far. If you use the radeon driver try a driver update.

Stefan
