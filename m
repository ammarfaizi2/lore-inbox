Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSEUEyp>; Tue, 21 May 2002 00:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316513AbSEUEyo>; Tue, 21 May 2002 00:54:44 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44318 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316512AbSEUEyn>; Tue, 21 May 2002 00:54:43 -0400
Date: Tue, 21 May 2002 00:54:39 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200205210454.g4L4sdH28825@devserv.devel.redhat.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allow aic7xx firmware to be built from BK tree.
In-Reply-To: <mailman.1021944350.2120.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch removes the two generate files (that are also in the
> distributed kernel) before attempting to regenerate them.

It may be a cleaner solution to fix the assembler so that
it writes into a temporary file then renames it into the
file given by -o. This should avoid the BK problem with
444 permissions.

-- Pete
