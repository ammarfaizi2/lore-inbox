Return-Path: <linux-kernel-owner+w=401wt.eu-S1751455AbXAPUbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbXAPUbf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbXAPUbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:31:35 -0500
Received: from khc.piap.pl ([195.187.100.11]:36469 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbXAPUbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:31:34 -0500
To: Chris Wedgwood <cw@f00f.org>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca>
	<45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net>
	<45AC1AEB.60805@shaw.ca> <45ACD918.2040204@scientia.net>
	<45ACE07D.3050207@shaw.ca>
	<20070116180154.GA1335@tuatara.stupidest.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 16 Jan 2007 21:31:31 +0100
In-Reply-To: <20070116180154.GA1335@tuatara.stupidest.org> (Chris Wedgwood's message of "Tue, 16 Jan 2007 10:01:54 -0800")
Message-ID: <m3d55eiuho.fsf@maximus.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> writes:

> right now i'm thinking if we can't figure out which cpu/bios
> combinations are safe we might almost be better off doing iommu=soft
> for *all* k8 stuff except for those that are whitelisted; though this
> seems extremely drastic

Do you (someone) have (maintain) a list of affected systems,
including motherboard type and possibly version, BIOS version and
CPU type? A similar list of unaffected systems with 4GB+ RAM could
be useful, too.

I'm afraid with default iommu=soft it will be a mystery forever.
-- 
Krzysztof Halasa
