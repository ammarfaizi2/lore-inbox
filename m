Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279583AbRJXUYa>; Wed, 24 Oct 2001 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRJXUYW>; Wed, 24 Oct 2001 16:24:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279583AbRJXUYH>; Wed, 24 Oct 2001 16:24:07 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] autofs4 symlink size
Date: 24 Oct 2001 13:24:10 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9r781a$q9n$1@cesium.transmeta.com>
In-Reply-To: <20011024102050.A12112@sigint.cs.purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011024102050.A12112@sigint.cs.purdue.edu>
By author:    linux@sigint.cs.purdue.edu
In newsgroup: linux.dev.kernel
>
> I sent this to the autofs4 maintainer a while ago, but never heard back.
> autofs4 doesn't return a size for the symlinks it creates, which is
> inconsistent with other filesystems.  (The Almquist shell uses the sizes
> of path components to allocate buffers during a walk, so it can't traverse
> autofs4-linked paths.)
> 

That's IMNSHO a bug in the Almquist shell, at least if autofs4 returns
zero, but it's also a bug in autofs4.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
