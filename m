Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWALJz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWALJz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWALJz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:55:26 -0500
Received: from relay03.pair.com ([209.68.5.17]:18449 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1030335AbWALJz0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:55:26 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: ck@vds.kolivas.org, oyvinst@student.matnat.uio.no
Subject: Re: [ck] Bad page state at free_hot_cold_page
Date: Thu, 12 Jan 2006 03:55:43 -0600
User-Agent: KMail/1.9
References: <200601120301.00361.chase.venters@clientec.com> <200601121047.13016.oyvinst@ifi.uio.no>
In-Reply-To: <200601121047.13016.oyvinst@ifi.uio.no>
Organization: Clientec, Inc.
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601120355.44290.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 03:47, Øyvind Stegard wrote:
> Don't run memtest yet.
>
> Got the same problem, it's ALSA related.
>
> The answer should be provided here:
> http://lkml.org/lkml/2005/12/9/106
>
> Upgrading to ALSA-1.0.11rc2 fixed the problem for me.. Apparently there are
> some memalloc compatibilty-issues, haven't looked very much into it.
> There's at patch provided in the LKML-thread.

Ah ha! Well, this looks like it'll be a quick fix. I'm building ALSA-1.0.11rc2 
now. 

> Øyvind

Thanks,
Chase
