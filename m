Return-Path: <linux-kernel-owner+w=401wt.eu-S1751950AbWLNSLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWLNSLD (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWLNSLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:11:03 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43098 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbWLNSLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:11:00 -0500
Date: Thu, 14 Dec 2006 20:10:57 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Karsten Weiss <K.Weiss@science-computing.de>
Cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2nd try] Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061214181056.GA3655@rhun.ibm.com>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <458051FD.1060900@scientia.net> <20061213195345.GA16112@tuatara.stupidest.org> <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de> <20061214092208.GB6674@rhun.haifa.ibm.com> <Pine.LNX.4.61.0612141215590.17792@palpatine.science-computing.de> <20061214115658.GR6674@rhun.haifa.ibm.com> <Pine.LNX.4.61.0612141356540.22485@palpatine.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612141356540.22485@palpatine.science-computing.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 02:16:31PM +0100, Karsten Weiss wrote:
> On Thu, 14 Dec 2006, Muli Ben-Yehuda wrote:
> 
> > The rest looks good. Please resend and I'll add my Acked-by.
> 
> Thanks a lot for your comments and suggestions. Here's my 2nd try:
> 
> ===
> 
> From: Karsten Weiss <knweiss@science-computing.de>
> 
> $ diffstat ~/iommu-patch_v2.patch
>  Documentation/kernel-parameters.txt   |    3
>  Documentation/x86_64/boot-options.txt |  104 +++++++++++++++++++++++-----------
>  arch/x86_64/Kconfig                   |   10 ++-
>  arch/x86_64/kernel/pci-dma.c          |   28 +--------
>  4 files changed, 87 insertions(+), 58 deletions(-)
> 
> Patch description:
> 
> - add SWIOTLB config help text
> - mention Documentation/x86_64/boot-options.txt in
>   Documentation/kernel-parameters.txt
> - remove the duplication of the iommu kernel parameter documentation.
> - Better explanation of some of the iommu kernel parameter options.
> - "32MB<<order" instead of "32MB^order".
> - Mention the default "order" value.
> - list the four existing PCI-DMA mapping implementations of arch x86_64
> - group the iommu= option keywords by PCI-DMA mapping implementation.
> - Distinguish iommu= option keywords from number arguments.
> - Explain the meaning of DAC and SAC.
> 
> Signed-off-by: Karsten Weiss <knweiss@science-computing.de>

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli
