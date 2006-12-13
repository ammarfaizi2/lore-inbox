Return-Path: <linux-kernel-owner+w=401wt.eu-S965140AbWLMUBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWLMUBG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWLMUBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:01:05 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:48332 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965136AbWLMUBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:01:04 -0500
X-YMail-OSG: oc_su80VM1lGzjvEiF8sY49j0S3NFX9bPaIWraOG9jwab5RPapZlrQ5oipoeVDxyxNS1nWxYdmwDabwqVnUQQ6c.J8PGuARRE5d0B7dJAwwbf3AAPWuhX6GIB1iPCuL0UjuLd2wvAvl3zg--
Date: Wed, 13 Dec 2006 11:54:20 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: Karsten Weiss <K.Weiss@science-computing.de>, linux-kernel@vger.kernel.org,
       Erik Andersen <andersen@codepoet.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061213195420.GB16112@tuatara.stupidest.org>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <4580529B.70202@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4580529B.70202@scientia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 08:20:59PM +0100, Christoph Anton Mitterer wrote:

> Did anyone made any test under Windows? I cannot set there
> iommu=soft, can I?

Windows never uses the hardware iommu, so it's always doing the
equivalent on iommu=soft
