Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSDOTzk>; Mon, 15 Apr 2002 15:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSDOTzj>; Mon, 15 Apr 2002 15:55:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49938 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313189AbSDOTzi>; Mon, 15 Apr 2002 15:55:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: link() security
Date: 15 Apr 2002 12:55:11 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a9fb6v$d2f$1@cesium.transmeta.com>
In-Reply-To: <20020415143641.A46232@hiwaay.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020415143641.A46232@hiwaay.net>
By author:    Chris Adams <cmadams@hiwaay.net>
In newsgroup: linux.dev.kernel
>
> Once upon a time, H. Peter Anvin <hpa@zytor.com> said:
> >Not to mention the fact that the single file mailbox design is itself
> >flawed.  Mailboxes are fundamentally directories, which news server
> >authors quickly realized.
> 
> Funny that news server authors realized that storing messages in files
> by themselves is a bad idea, while at the same time mail server authors
> realized that storing messages together in a single file is a bad idea.
> Which one is right?  Both?  Neither?
> 

It depends on your access patterns.  Newer news server use what I
would classify as custom filesystems (which is what binary databases
are, by and large) rather than "single files."

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
