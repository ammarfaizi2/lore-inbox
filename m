Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278800AbRKSNn0>; Mon, 19 Nov 2001 08:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278810AbRKSNnQ>; Mon, 19 Nov 2001 08:43:16 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:51163 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278800AbRKSNnA>; Mon, 19 Nov 2001 08:43:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Subject: Re: swap?
Date: Mon, 19 Nov 2001 13:42:54 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.30.0111190145510.766-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0111190145510.766-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165ohF-0006WW-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 12:46 am, Roy Sigurd Karlsbakk wrote:
> What about a tux-only system?
>
> should I disable swap?

No, probably not. Having some swapspace (or, to keep the .nl pedant happy, 
"pagespace") available will allow the kernel to migrate unused pages to disk, 
making more room available for caching of your WWW site's content. Being part 
of the kernel, Tux's code will all be locked in memory anyway; the rest of 
free RAM will be used for caching content.


James.
