Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVAaLjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVAaLjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVAaLjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:39:33 -0500
Received: from ext-nj2gw-5.online-age.net ([64.14.56.41]:24287 "EHLO
	ext-nj2gw-5.online-age.net") by vger.kernel.org with ESMTP
	id S261153AbVAaLjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:39:31 -0500
Date: Mon, 31 Jan 2005 12:36:33 +0100
From: Kiniger <karl.kiniger@med.ge.com>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How peek at tcp socket data w/o reading it
Message-ID: <20050131113633.GA4184@wszip-kinigka.euro.med.ge.com>
References: <20050131104532.GA3208@wszip-kinigka.euro.med.ge.com> <20050131121616.1d35c69a@phoebee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131121616.1d35c69a@phoebee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks very much,

thats exactly what I needed.

Karl

On Mon, Jan 31, 2005 at 12:16:16PM +0100, Martin Zwickel wrote:
> 
>    On Mon, 31 Jan 2005 11:45:32 +0100
>    "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com> bubbled:
> 
>    > Hi,
>    >
>    > hack wanted:
>    >
>    > is it possible to peek a few bytes from a tcp socket which is
>    > ready to read without actually reading the data? (or some
>    > means to push already read data back similar to ungetc)
> 
>    ret = recv(fd, buf, len, MSG_PEEK);
> 
>    --
>    MyExcuse:
>    telnet: Unable to connect to remote host: Connection refused
> 
>    Martin Zwickel <martin.zwickel@technotrend.de>
>    Research & Development
> 
>    TechnoTrend AG <[1]http://www.technotrend.de>
>    )
> 
> References
> 
>    1. http://www.technotrend.de/

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
