Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUJYTgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUJYTgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUJYTeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:34:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:3226 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261160AbUJYTdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:33:35 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] use mmiowb in qla1280.c
Date: Mon, 25 Oct 2004 12:33:17 -0700
User-Agent: KMail/1.7
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, jeremy@sgi.com, jes@sgi.com
References: <200410211613.19601.jbarnes@engr.sgi.com> <200410250918.01786.jbarnes@engr.sgi.com> <20041025120223.3633ea4c.akpm@osdl.org>
In-Reply-To: <20041025120223.3633ea4c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251233.17683.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 25, 2004 12:02 pm, Andrew Morton wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > > *** Warning: "mmiowb" [drivers/scsi/qla1280.ko] undefined!
> >
> >  Only works in Andrew's tree until he pushes mmiowb to Linus.
>
> I haven't been following this stuff at all closely and I need help
> determining which patches should be pushed, and when.  Please.

I think it's safe to push the main mmiowb() patch now, then James and the 
netdev tree can start including driver changes to make use of it.

Thanks,
Jesse
