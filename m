Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbSBGKCB>; Thu, 7 Feb 2002 05:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287048AbSBGKBw>; Thu, 7 Feb 2002 05:01:52 -0500
Received: from borderworlds.dk ([193.162.142.101]:18184 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S287045AbSBGKBh>; Thu, 7 Feb 2002 05:01:37 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with iso9660 as initrd
In-Reply-To: <m3r8ny8by5.fsf@borg.borderworlds.dk>
	<a3sei4$h5p$1@cesium.transmeta.com>
	<m3n0yl90xb.fsf@borg.borderworlds.dk>
	<a3te3d$7f2$1@cesium.transmeta.com>
From: Christian Laursen <xi@borderworlds.dk>
Date: 07 Feb 2002 11:01:33 +0100
In-Reply-To: <a3te3d$7f2$1@cesium.transmeta.com>
Message-ID: <m3g04dy5j6.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <m3n0yl90xb.fsf@borg.borderworlds.dk>
> By author:    Christian Laursen <xi@borderworlds.dk>
> In newsgroup: linux.dev.kernel
> > > 
> > > Also, you don't have CONFIG_ZISOFS set...
> > 
> > Sorry for not being precise enough. It is not a zisofs, just compressed
> > with gzip as usual for an initrd image.
> > 
> 
> Still unusual, though.  Why iso9660?  It's not particularly well
> suited for an initrd, especially because of all the redundant data
> structures and extra blocking.

Mostly because it is easily scriptable to build it with tools usually
available.

-- 
Best regards
    Christian Laursen
