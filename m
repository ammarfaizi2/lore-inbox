Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUBEVYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUBEVYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:24:21 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:54692 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266870AbUBEVYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:24:19 -0500
Date: Thu, 5 Feb 2004 22:24:17 +0100
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205212417.GI10547@stud.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Okay, we may be dealing with the buggy hardware at this point. Would
> it make sense to tell the drive to flush it caches? If there's no
> other possibility, we might want cdrecord to reset drive at the end of
> blank and/or to make it eject...

It's not the drive, it's the kernel. We have to tell the kernel to
*flush* *it's* buffers when doing an umount. See my other posting.

	Thomas
