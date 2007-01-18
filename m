Return-Path: <linux-kernel-owner+w=401wt.eu-S1751557AbXARVh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbXARVh4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbXARVh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:37:56 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38161 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbXARVhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:37:55 -0500
Message-ID: <45AFE8AB.6070209@zytor.com>
Date: Thu, 18 Jan 2007 13:37:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Valdis.Kletnieks@vt.edu,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "obsolete" versus "deprecated", and a new config option?
References: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6> <200701172154.l0HLs3BM021024@turing-police.cc.vt.edu>            <Pine.LNX.4.64.0701171654480.4298@CPE00045a9c397f-CM001225dbafb6> <200701172254.l0HMsDMK022934@turing-police.cc.vt.edu> <Pine.LNX.4.64.0701171749430.4760@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701171749430.4760@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> 
> that's entirely a judgment call on the part of the code's maintainer.
> if something is both obsolete and broken, then make it depend on
> *both* OBSOLETE and BROKEN if you want.  no big deal.
> 

Yup.

OBSOLETE = might be broken, no one is planning to maintain it.
BROKEN = known to be broken.

They're by and large orthogonal.

	-hpa
