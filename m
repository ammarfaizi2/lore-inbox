Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277183AbRJDSX5>; Thu, 4 Oct 2001 14:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277201AbRJDSXr>; Thu, 4 Oct 2001 14:23:47 -0400
Received: from [212.172.122.16] ([212.172.122.16]:5903 "EHLO qmail.root.at")
	by vger.kernel.org with ESMTP id <S277183AbRJDSXo>;
	Thu, 4 Oct 2001 14:23:44 -0400
Date: Thu, 4 Oct 2001 20:24:11 +0200 (CEST)
From: Karl Pitrich <pit@root.at>
To: "lk@Aniela.EU.ORG" <lk@Aniela.EU.ORG>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 100% sync block device on 2.2 ?
In-Reply-To: <Pine.LNX.4.33.0110042115300.398-100000@ns1.Aniela.EU.ORG>
Message-ID: <Pine.LNX.4.33.0110042022560.1056-100000@warp.root.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, lk@Aniela.EU.ORG wrote:

>
> while :; do sync ; done
>
>
> and everything should be in sync :)

sync does not call fsync_dev(), nor it calls this flush ioctl i
implemented in my driver.
sync seems just to sync the vfs.

