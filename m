Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUJVR5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUJVR5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUJVRvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:51:48 -0400
Received: from pat.uio.no ([129.240.130.16]:37116 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S266864AbUJVRrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:47:39 -0400
Subject: Re: Kernel 2.6.x: nfs warning: mount version older than kernel
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
In-Reply-To: <Pine.LNX.4.61.0410220727120.514@p500>
References: <Pine.LNX.4.61.0410220727120.514@p500>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 13:47:28 -0400
Message-Id: <1098467248.8813.56.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 22.10.2004 Klokka 07:29 (-0400) skreiv Justin Piszcz:
> # mount -a
> # dmesg | tail -n 5
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> # mount --version
> mount: mount-2.12h
> #
> 
> I am using the latest util-linux from the developers site, so I am 
> curious, why do I get this warning in dmesg/ring-buffer?
> 

The 2.6 changes to the nfs_mount structure have not yet been merged
upstream. Mea culpa...

Cheer,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

