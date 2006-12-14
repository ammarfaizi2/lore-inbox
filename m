Return-Path: <linux-kernel-owner+w=401wt.eu-S932176AbWLNJeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWLNJeb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWLNJeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:34:31 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:29324 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932176AbWLNJea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:34:30 -0500
X-YMail-OSG: tTlwq0kVM1muk8GWO.y_NaE1azVkS40NDbXPGwdQIdWWR_39W2auven4NqoHT370qpgU_948Ct_O3ebhq9qZAPBUP0Sp5ZVVbPyleNU7vGXtAKwrvxX60r5ITE5oZpebW97iAREOBAL3AYA-
Date: Thu, 14 Dec 2006 01:34:28 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: Karsten Weiss <knweiss@gmx.de>, linux-kernel@vger.kernel.org, ak@suse.de,
       andersen@codepoet.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061214093428.GA1086@tuatara.stupidest.org>
References: <4570CF26.8070800@scientia.net> <Pine.LNX.4.64.0612021048200.2981@addx.localnet> <45804C0B.4030109@scientia.net> <Pine.LNX.4.64.0612132014340.2963@addx.localnet> <45805E71.6060006@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45805E71.6060006@scientia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 09:11:29PM +0100, Christoph Anton Mitterer wrote:

> - error in the Opteron (memory controller)
> - error in the Nvidia chipsets
> - error in the kernel

My guess without further information would be that some, but not all
BIOSes are doing some work to avoid this.

Does anyone have an amd64 with an nforce4 chipset and >4GB that does
NOT have this problem?  If so it might be worth chasing the BIOS
vendors to see what errata they are dealing with.
