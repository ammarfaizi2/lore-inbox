Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbUKPKOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbUKPKOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbUKPKOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:14:23 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:21256 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261730AbUKPKNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:13:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MhiSSfYytPnVDzSGjNG3qIzBszmvl9EfrAQ5ZxdU3H8gnu24Af2RfJIMZ3txwq3//E9pDwgYyp87QHBnoiQDDscqbfthkhRPCCjeY4Niz89fuJfBtZdheOz9RGQI891LmsVo72YEAl3yEYxYGIyZB4fUlOThMMmDP7oVINi+V7w=
Message-ID: <84144f0204111602136a9bbded@mail.gmail.com>
Date: Tue, 16 Nov 2004 12:13:29 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

On Tue, 16 Nov 2004 10:08:54 +0100, Miklos Szeredi <miklos@szeredi.hu> wrote:
> I did send a pointer to the cleaned up patch, maybe this wasn't
> explicit enough:
> 
>   http://fuse.sourceforge.net/kernel_patches/fuse-2.1-2.6.10-rc2.patch

Few comments:

   - Breaks if CONFIG_PROC_FS is not enabled.
   - Explicit casts are not needed when converting void pointers
(found in various places).

                             Pekka
