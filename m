Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUF0CIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUF0CIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 22:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267240AbUF0CIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 22:08:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57740 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266517AbUF0CIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 22:08:37 -0400
Date: Sat, 26 Jun 2004 19:08:27 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org,
       USB Storage List <usb-storage@lists.one-eyed-alien.net>,
       stern@rowland.harvard.edu, david-b@pacbell.net, oliver@neukum.org,
       zaitcev@redhat.com
Subject: Re: drivers/block/ub.c
Message-Id: <20040626190827.7c919940@lembas.zaitcev.lan>
In-Reply-To: <20040626201225.GA2149@one-eyed-alien.net>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<20040626201225.GA2149@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004 13:12:25 -0700
Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

> Would I be correct in the following assessments:
> (1) UB only supports direct-access type devices
> (2) UB only supports 'transparent scsi' devices
> (3) UB only supports 'bulk-only transport' devices

Yes, you would. Someone mentioned on usb-storage list that Windows supports
two things only without extra drivers: Transparent SCSI over Bulk, and UFI.
IIRC, it was Pat. So, I thought maybe to tackle drivers/block/ufi.c later,
to share design concept and some libraries with ub. The rest stays with
usb-storage. But the real life always introduces corrections to plans, so
let's not get too far ahead.

-- Pete
