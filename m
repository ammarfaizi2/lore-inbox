Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284983AbRLFFJ1>; Thu, 6 Dec 2001 00:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284982AbRLFFJR>; Thu, 6 Dec 2001 00:09:17 -0500
Received: from zero.tech9.net ([209.61.188.187]:8197 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284981AbRLFFJI>;
	Thu, 6 Dec 2001 00:09:08 -0500
Subject: Re: [PATCH] simple ide without proc compile fix
From: Robert Love <rml@tech9.net>
To: David Weinehall <tao@acc.umu.se>
Cc: marcelo@conectiva.com.br, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011206054826.Z360@khan.acc.umu.se>
In-Reply-To: <1007594451.28567.18.camel@phantasy> 
	<20011206054826.Z360@khan.acc.umu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 06 Dec 2001 00:08:01 -0500
Message-Id: <1007615282.10144.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-05 at 23:48, David Weinehall wrote:

> Wouldn't a dummy, in case of no proc, be preferable? That'd make it
> possible to remove all the #ifdef CONFIG_PROC_FS

Yes, but like I said I'm just fixing a bug (by mimicking the other
code's behavior).  It certainly is preferable to do what you say.

There is one issue, though.  IDE code doesn't seem to have any common
header.  With the function in multiple files, that complicates thing ...

	Robert Love

