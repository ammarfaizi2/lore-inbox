Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSCSSHE>; Tue, 19 Mar 2002 13:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSCSSGy>; Tue, 19 Mar 2002 13:06:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22279 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287817AbSCSSGf>; Tue, 19 Mar 2002 13:06:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] zlib double-free bug
Date: 19 Mar 2002 10:06:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a77umb$t3s$1@cesium.transmeta.com>
In-Reply-To: <15510.25987.233438.112897@argo.ozlabs.ibm.com> <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com>
By author:    David Woodhouse <dwmw2@redhat.com>
In newsgroup: linux.dev.kernel
>
> On Tue, 19 Mar 2002, Paul Mackerras wrote:
> 
> > David Woodhouse writes:
> > 
> > > After it's been in -ac for a while without mishap I'll ask Marcelo to
> > > consider it - possibly for 2.4.20-pre1.
> > 
> > Yep, that sounds good to me.  For now, I think my patch should go in
> > for 2.4.19.
> 
> Absolutely - sorry, I didn't mean to imply otherwise.
> 
> For the record - it's not worth bothering with fs/jffs2/zlib.c; if they 
> can corrupt your file system on the medium, why bother with cracking zlib? 
> :)
> 

Removable media?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
