Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVILJk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVILJk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVILJk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:40:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751265AbVILJk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:40:57 -0400
Date: Mon, 12 Sep 2005 02:40:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: michal.k.k.piotrowski@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: [OOPS] 2.6.13-mm2 scsi, sata, ich5
Message-Id: <20050912024027.39a1d7be.akpm@osdl.org>
In-Reply-To: <6bffcb0e05091202296a07f1ad@mail.gmail.com>
References: <20050911232109.35720176.akpm@osdl.org>
	<6bffcb0e05091202296a07f1ad@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(re-adding linux-scsi)

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> Hi,
> 
> On 12/09/05, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > This is a strange trace.   I assume one of the WARN_ON()s in
> > kref_put() has triggered and there's stack stuff missing.   Or
> > Maybe it's an oops under scsi_end_request(), but the oops trace doesn't
> > use show_trace(), whcih that output is from.   But if it's not
> > an oops, why is the Code: dump there.
> > 
> > Head spins.   Michal, can you try to gather another trace?   Is there
> > info missing from this one?
> > 
> > (It's quite possibly a scsi thing rather than a sata thing, btw).
> > 
> 
> The oops always hapen about 3 seconds after system start booting. When
> it hapen I can't see what is up, because shift+pageup doesn't work.
> So, AFAIK the only way to catch that oops is serial console?
> 
> Regards,
> Michal Piotrowski
