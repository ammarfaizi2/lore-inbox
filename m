Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289598AbSAJSmj>; Thu, 10 Jan 2002 13:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289590AbSAJSmU>; Thu, 10 Jan 2002 13:42:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55053 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289592AbSAJSmK>; Thu, 10 Jan 2002 13:42:10 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] klibc requirements
Date: 10 Jan 2002 10:41:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1kn9d$u35$1@cesium.transmeta.com>
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109060951.GA18024@kroah.com> <a1grbm$n6o$1@cesium.transmeta.com> <20020110173029.7616f752.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020110173029.7616f752.rusty@rustcorp.com.au>
By author:    Rusty Russell <rusty@rustcorp.com.au>
In newsgroup: linux.dev.kernel
> 
> HPA,
> 	gnu cpio (v 2.4.2) actually puts the contents in the *last*
> entry, for hardlinks in "newc" format.  This probably means you should
> specify that if it's a found tuple, and c_filesize is non-zero,
> overwrite the contents of the file.
> 

Check.  I must admit this greatly surprises me (since it means that it
needs to do more than one pass), but it certainly isn't making the
spec any more difficult.  As I said, it's a draft.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
