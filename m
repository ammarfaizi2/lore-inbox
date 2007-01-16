Return-Path: <linux-kernel-owner+w=401wt.eu-S1751469AbXAPUfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbXAPUfi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbXAPUfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:35:38 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:35262 "HELO
	smtp101.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751469AbXAPUfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:35:37 -0500
X-YMail-OSG: _RABltwVM1kE0Awme6AMncyySwoj9JeQH8WJhL7dCj14zSlmjpGkwhW7IV6TTsnWQhoQeQzvljOa_4JWiMsFMLPwerCMBPOQzIrrJcEqCoPeB9B_F6VMApa82KHKebCq4ApkSQdP4y_ueQf6oW2hvxudHxUvmX8onGiADcZU8lMkcUJqgdWBTdMW2EDG
Date: Tue, 16 Jan 2007 12:35:34 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Message-ID: <20070116203534.GA4991@tuatara.stupidest.org>
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca> <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net> <45AC1AEB.60805@shaw.ca> <45ACD918.2040204@scientia.net> <45ACE07D.3050207@shaw.ca> <20070116180154.GA1335@tuatara.stupidest.org> <m3d55eiuho.fsf@maximus.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d55eiuho.fsf@maximus.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 09:31:31PM +0100, Krzysztof Halasa wrote:

> Do you (someone) have (maintain) a list of affected systems,
> including motherboard type and possibly version, BIOS version and
> CPU type? A similar list of unaffected systems with 4GB+ RAM could
> be useful, too.

All I know is that some system hit this and some don't seem to.  Why
it's not clear.

> I'm afraid with default iommu=soft it will be a mystery forever.

Right, but given windows doesn't use the iommu at all and that a lot
of newer hardware/drivers doesn't need it it might be the safest
option since it clearly has been causing corruption for a number of
people for well over a year now.

