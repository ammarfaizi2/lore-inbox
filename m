Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbULCWFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbULCWFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbULCWEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:04:44 -0500
Received: from smtp.istop.com ([66.11.167.126]:16272 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262408AbULCWC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:02:57 -0500
From: Daniel Phillips <phillips@istop.com>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Date: Fri, 3 Dec 2004 17:07:45 -0500
User-Agent: KMail/1.7
Cc: Miklos Szeredi <miklos@szeredi.hu>, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu> <41ACE816.50104@argo.co.il>
In-Reply-To: <41ACE816.50104@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412031707.46114.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avi,

On Tuesday 30 November 2004 16:37, Avi Kivity wrote:
> The situation with userspace filesystems is:
>
>   some process allocates memory, blocking on kswapd as memory is full
>   kswapd calls userspace filesystem to free memory
>   userspace filesystem calls kernel, which allocates memory and blocks
> on kswapd
>   eventually all processes in the system block on kswapd
>
> I have observed (and fixed) this on a real system.

What was your fix?

Regards,

Daniel
