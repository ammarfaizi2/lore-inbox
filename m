Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSBGIdU>; Thu, 7 Feb 2002 03:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSBGIdK>; Thu, 7 Feb 2002 03:33:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26120 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286322AbSBGIdC>; Thu, 7 Feb 2002 03:33:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Problems with iso9660 as initrd
Date: 7 Feb 2002 00:32:45 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3te3d$7f2$1@cesium.transmeta.com>
In-Reply-To: <m3r8ny8by5.fsf@borg.borderworlds.dk> <a3sei4$h5p$1@cesium.transmeta.com> <m3n0yl90xb.fsf@borg.borderworlds.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m3n0yl90xb.fsf@borg.borderworlds.dk>
By author:    Christian Laursen <xi@borderworlds.dk>
In newsgroup: linux.dev.kernel
> > 
> > Also, you don't have CONFIG_ZISOFS set...
> 
> Sorry for not being precise enough. It is not a zisofs, just compressed
> with gzip as usual for an initrd image.
> 

Still unusual, though.  Why iso9660?  It's not particularly well
suited for an initrd, especially because of all the redundant data
structures and extra blocking.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
