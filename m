Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVKEE4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVKEE4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVKEE4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:56:18 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:51793 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751205AbVKEE4R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:56:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iz/87G6M03pbHQqpaeRzfIPAHU1AnNppuiygCT4UpQ3xQaBVQv7W+b12fh+AiAoDIKSmg61YeEcamP3rvAvNmY62cgdP+3LIHbGyLlrcct6tMvQw7YD4asmZt6QNhSNkybC1asDARovt4hnoRAcevfJOzLtzLcTwOqk3PONw36o=
Message-ID: <c216304e0511042056t79f07d0bi7b4c763838b2c401@mail.gmail.com>
Date: Sat, 5 Nov 2005 10:26:16 +0530
From: Ashutosh Naik <ashutosh.lkml@gmail.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: [stable] Re: [PATCH] scsi - Fix Broken Qlogic ISP2x00 Device Driver
Cc: Chris Wright <chrisw@osdl.org>, Ashutosh Naik <ashutosh.naik@gmail.com>,
       support@qlogic.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, stable@kernel.org
In-Reply-To: <20051102184705.GD5889@plapn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450511012313v25e292duf7b64da0ebf07835@mail.gmail.com>
	 <20051102080711.GB626@plapn>
	 <20051102082142.GW5856@shell0.pdx.osdl.net>
	 <20051102184705.GD5889@plapn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/3/05, Andrew Vasquez <andrew.vasquez@qlogic.com> wrote:

> Sure.  But, the interface changes present in scsi-misc-2.6, notably:
>
> http://kernel.org/git/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=19a7b4aebf9ad435c69a7e39930338499af4d152
>
> obviate the need for the explicit '#include' -- there are no longer
> any explicit calls to the fc_remote_port_*() functions within
> qla_rscn.c.

Well, hopefully the above code should get merged soon ( in 2.6.15 
hopefully), but until then, I think the current tree should be fixed
with the patch, if the interface changes are not reflected in 2.6.15

Regards
Ashutosh
