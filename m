Return-Path: <linux-kernel-owner+w=401wt.eu-S932113AbXARJ3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbXARJ3W (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbXARJ3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:29:22 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:61431 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148AbXARJ3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:29:21 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=FcBLOoVDRykDnmVa68PvCyZOAKXQQ2BZ7XFsyX2mgwAvRSIv97pVKkPDa6AlNLCnbHwaT/Cluhy2bXadEqGHr0gK0pjaE1u11l0VCefaQnX6yawynHjr9sgfK/HZBX/2P5CiQRUEGKVGhZFGBzKOMb2N9F5Yvf3kL8I0ZFq5djE=
Message-ID: <45AF3DEA.1070309@gmail.com>
Date: Thu, 18 Jan 2007 10:29:14 +0100
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de>
In-Reply-To: <200701170829.54540.ak@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
From: joachim <joachim.kernel@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote on 22:29 16/01/2007 +0100 :
> AMD is looking at the issue. Only Nvidia chipsets seem to be affected,
> although there were similar problems on VIA in the past too.
> Unless a good workaround comes around soon I'll probably default
> to iommu=soft on Nvidia.
> 
> -Andi

Not only has it only been on Nvidia chipsets but we have only seen
reports on the Nvidia CK804 SATA controller.  Please write in or add
yourself to the bugzilla entry [1] and tell us which hardware you have
if you get 4kB pagesize corruption and it goes away with "iommu=soft".

thanks
-joachim

[1] http://bugzilla.kernel.org/show_bug.cgi?id=7768
