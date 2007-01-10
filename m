Return-Path: <linux-kernel-owner+w=401wt.eu-S932707AbXAJDes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbXAJDes (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 22:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbXAJDes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 22:34:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:34700 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932707AbXAJDer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 22:34:47 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZZuGcr+hnqypeE9TGmQrwHEYO+K6Vy1XRo+3fgJy9hgFNwJ+vkEbxOxpeu/3sRIJFue0f0TKPDN0osW/CirkEPExCHFU5Y74Gp9cq5vHrss33llDEMMd7EnWrfosHiXrke0CLdNucXHCtCVmuLRQwo6U8rV/bhCpmRyYz8fybm8=
Message-ID: <a44ae5cd0701091934h7f4ed663xfd57184df67cb86@mail.gmail.com>
Date: Tue, 9 Jan 2007 21:34:46 -0600
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: BUG: bad unlock balance detected! -- [<c017986d>] generic_sync_sb_inodes+0x26a/0x275
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20070109192459.1820814f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0701091917o13fc3badud118364a5e8be9dd@mail.gmail.com>
	 <20070109192459.1820814f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/07, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 9 Jan 2007 21:17:30 -0600
> "Miles Lane" <miles.lane@gmail.com> wrote:
>
> > [ BUG: bad unlock balance detected! ]
> > -------------------------------------
> > swapper/0 is trying to release lock (inode_lock) at:
> > [<c017986d>] generic_sync_sb_inodes+0x26a/0x275
>
> If this is 2.6.20-rc3-mm1, please ensure that the fixes from
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/hot-fixes
> are applied.

Oh shoot.  My apologies.  I downloaded the patch and forgot to apply it.

          Miles
