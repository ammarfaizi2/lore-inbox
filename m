Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVADCFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVADCFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVADCFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:05:20 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:50878 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261953AbVADCFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:05:16 -0500
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: Nicholas Miell <nmiell@comcast.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: tridge@samba.org, Michael B Allen <mba2000@ioplex.com>, sfrench@samba.org,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       aia21@cantab.net, hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D9F5FB.7080204@zytor.com>
References: <41D9C635.1090703@zytor.com>
	 <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
	 <41D9D65D.7050001@zytor.com> <16857.57572.25294.431752@samba.org>
	 <41D9E23A.4010608@zytor.com>
	 <1104802319.3604.71.camel@localhost.localdomain>
	 <41D9F5FB.7080204@zytor.com>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 18:05:14 -0800
Message-Id: <1104804314.3604.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 17:48 -0800, H. Peter Anvin wrote:
> What you're neglecting is that there is a LARGE class of metadata where 
> the important thing is that you store them; if you don't know what they 
> are you merely ignore them and keep them as-is.
> 
> There is no place for those in the current design.

That's what the user namespace is for -- the kernel has no interest in
its contents, it just stores it as-is for apps that do.

-- 
Nicholas Miell <nmiell@comcast.net>

