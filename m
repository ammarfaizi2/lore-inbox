Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVILJ35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVILJ35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVILJ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:29:57 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:1295 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751258AbVILJ35 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:29:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NS5twOIDnojoQmZsytybhTMw746WXOmFwhC/JTurqYqyVbYEltoZFJCbi0hG3/DjsugyZdtfyfl5tQIBMK4VNe8v0yRozhGascbMC2C1VSrj65SZi2LXXIqXBgiG5P8cOCYVPxY7u8SCZWNIFgAqA8JcBej98O1tK2nAtuI9umg=
Message-ID: <6bffcb0e05091202296a07f1ad@mail.gmail.com>
Date: Mon, 12 Sep 2005 11:29:52 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [OOPS] 2.6.13-mm2 scsi, sata, ich5
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050911232109.35720176.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050911232109.35720176.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/09/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> This is a strange trace.   I assume one of the WARN_ON()s in
> kref_put() has triggered and there's stack stuff missing.   Or
> Maybe it's an oops under scsi_end_request(), but the oops trace doesn't
> use show_trace(), whcih that output is from.   But if it's not
> an oops, why is the Code: dump there.
> 
> Head spins.   Michal, can you try to gather another trace?   Is there
> info missing from this one?
> 
> (It's quite possibly a scsi thing rather than a sata thing, btw).
> 

The oops always hapen about 3 seconds after system start booting. When
it hapen I can't see what is up, because shift+pageup doesn't work.
So, AFAIK the only way to catch that oops is serial console?

Regards,
Michal Piotrowski
