Return-Path: <linux-kernel-owner+w=401wt.eu-S1751100AbXARBWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbXARBWQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 20:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbXARBWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 20:22:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:20642 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbXARBWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 20:22:15 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=sctugSPlJZfew3hP46FkXP9D65T+5AoTL5EO+k+tGvM+tVzSADNsr10Mn31rtZ7y6ArrlKGjbxrkLYO1mbq3BlFEvn6PBVjpHWDTfvyDiJANvnMPRT/mz4r+1wIG1hEls7jhW2ZG3rrvOTKdPMrueBSW1jrFU3GzN9yu11OChcM=
Message-ID: <45AECBBE.60806@gmail.com>
Date: Thu, 18 Jan 2007 10:22:06 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
References: <45841710.9040900@t-online.de> <4587F87C.2050100@gmail.com> <45883299.2050209@t-online.de> <45887CD8.5090100@gmail.com> <458AE5FB.7080607@t-online.de> <4591FE96.1080606@gmail.com> <459346C4.1030802@gmail.com> <45941F1E.2080808@t-online.de> <459A482C.6020809@gmail.com> <45A296BC.8020208@t-online.de> <45AE30A8.70802@gmail.com> <45AE9934.6040009@t-online.de>
In-Reply-To: <45AE9934.6040009@t-online.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> How comes that there is no such problem if I connect the drive
> via an USB SATA adapter?

Ah... right.  I forgot about that.  Scrap my analysis.  What happens is
really weird tho.

> Do you think it would be reasonable to send a bug report to Samsung,
> and see what they say? I would need some documentation about these
> MMC commands, though. Is this part of some "Red Book" standard, or
> so?

Yeap, reporting is probably a good idea.  libdvdread ppl would be
interested too.  MMC is SCSI command set standard for ODDs and can be
found at t10.org.

I don't think we can proceed with kernel debugging before gathering more
info about this problem.  Feel free to cc me when you ask people about
this problem.  I really like the dvd writer and would love to see the
problem ironed out.

Thanks.

-- 
tejun
