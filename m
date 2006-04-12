Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWDLQ6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWDLQ6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 12:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWDLQ6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 12:58:33 -0400
Received: from uproxy.gmail.com ([66.249.92.168]:53580 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932212AbWDLQ6c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 12:58:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DpyL0FJZzyvskYvEFakGw3vb+XPL8IQvVPKSPzhml4M2WK6nNTv8K18qT754ZZR9Hszwre326VYfMS2DyTEw5MYa+3EUvtcG9RmBCLlVknpyqTR5Vy0InGPe2YxkuOtay4aoleVHPbhQdM3M00ucYbdd+4JJ3hJCN7ydR582mzg=
Message-ID: <87f94c370604120958m7ff116a5h4090701cd4936b8@mail.gmail.com>
Date: Wed, 12 Apr 2006 12:58:30 -0400
From: "Greg Freemyer" <greg.freemyer@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: libata-pata works on ICH4-M
Cc: "Gabor Gombas" <gombasg@sztaki.hu>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Carl-Daniel Hailfinger" <c-d.hailfinger.devel.2006@gmx.net>,
       linux-ide@vger.kernel.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <443B9EBB.6010607@gmx.net>
	 <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
	 <1144832990.1952.20.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr>
	 <1144852703.1952.36.camel@localhost.localdomain>
	 <20060412151930.GH4919@boogie.lpds.sztaki.hu>
	 <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> Ask the hdparm maintainers. Its mostly obsoleted by blktool and the like
> >> which are generic
> >
> ># hdparm -M 128 /dev/sda
> >
> The 's' is a classical indicator for somehow use of scsi. If that can be
> changed, the world is fine :)
>
>
> Jan Engelhardt

IIRC to get hdparm to talk to sata drives via libata you have use:

hdparm -d ata /dev/sda

Greg
--
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
