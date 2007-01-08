Return-Path: <linux-kernel-owner+w=401wt.eu-S1422712AbXAHTzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbXAHTzJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422713AbXAHTzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:55:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:21905 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422712AbXAHTzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:55:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rMbjsSs0t297UNwRH1neQcfMWBDjueYTVyCK+o5M7UBgUHSXDNhtlvz7JuY0i52nQf52YpQorVKabw1gdKL3fp2Rh/bZSwB3NZpe0N45nS0stPT2Mt3p0tyCr/VDGD7+LRH1OfPz0WUYJWJL7qMUa5XSCVXWdmlbpR5jVHmix+s=
Message-ID: <58cb370e0701081155j7376d15dv32e3b65906c8d325@mail.gmail.com>
Date: Mon, 8 Jan 2007 20:55:05 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Michael Bueker" <m.bueker@berlin.de>
Subject: Re: No DMA with HTP370 IDE controller
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45A29690.3040003@berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45A29690.3040003@berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/07, Michael Bueker <m.bueker@berlin.de> wrote:
> Hello,
>
> [please CC me upon replying - thank you]
>
> I have a Highpoint 370 PCI IDE controller, and both my 2.6.18.2 and
> Knoppix 5's 2.6.17 display the following messages:

Please try 2.6.20-rc4 and 2.6.20-rc3-mm1.

Both contain many fixes to IDE hpt driver (but -mm some more than vanilla).

Bart
