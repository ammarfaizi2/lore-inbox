Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUABAnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUABAnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:43:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:2773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262041AbUABAnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:43:22 -0500
Date: Thu, 1 Jan 2004 16:43:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: mulix@mulix.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-Id: <20040101164359.3656f0f7.akpm@osdl.org>
In-Reply-To: <20040102003950.GF1882@matchmail.com>
References: <20031229183846.GI13481@actcom.co.il>
	<Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
	<20040101235147.GC1718@actcom.co.il>
	<20040101160420.6a326d0a.akpm@osdl.org>
	<20040102001203.GD1718@actcom.co.il>
	<20040101162643.579af2bf.akpm@osdl.org>
	<20040102003950.GF1882@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> > Nah, leave it as is.  I'm just having a little whine.  I added a nifty
>  > trailing-whitespace-detector to patch-scripts a while back and it's telling
>  > me that a *lot* of people use broken editors.
>  > 
> 
>  And if their editor changed the whitespace you'd get a lot more patches with
>  shitespace cleanups mixed in, and they'd have to clean up thhose patches... ;)

That's different.  I refer to patches which *add* trailing
whitespace: ^+.*[ ]$

I usually strip it out for them.  This has the potential to irritate people
because it can cause rejects for followup patches, but nobody has yet
mentioned it.


