Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTFXHm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 03:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTFXHm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 03:42:29 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:64222 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263918AbTFXHm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 03:42:29 -0400
Date: Tue, 24 Jun 2003 00:57:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm1
Message-Id: <20030624005720.06b2d3d0.akpm@digeo.com>
In-Reply-To: <200306241045.15886.kde@myrealbox.com>
References: <20030623232908.036a1bd2.akpm@digeo.com>
	<200306241045.15886.kde@myrealbox.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2003 07:56:37.0223 (UTC) FILETIME=[2351AF70:01C33A26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"ismail (cartman) donmez" <kde@myrealbox.com> wrote:
>
> include/linux/mm.h: In function `lowmem_page_address':
>  include/linux/mm.h:344: error: `__PAGE_OFFSET' undeclared (first use in this 
>  function)

The configurable PAGE_OFFSET patch seems to confuse the build system sometimes.

Do another `make oldconfig', that should flush it out.
