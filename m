Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281794AbRKQRzr>; Sat, 17 Nov 2001 12:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281792AbRKQRzh>; Sat, 17 Nov 2001 12:55:37 -0500
Received: from pc-62-30-255-29-az.blueyonder.co.uk ([62.30.255.29]:46069 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S281788AbRKQRzZ>; Sat, 17 Nov 2001 12:55:25 -0500
Date: Sat, 17 Nov 2001 17:52:53 +0000
From: Jamie Lokier <lfs@tantalophile.demon.co.uk>
To: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        avfs@fazekas.hu
Subject: Re: Introducing FUSE: Filesystem in USErspace
Message-ID: <20011117175253.A5003@kushida.jlokier.co.uk>
In-Reply-To: <200111121128.MAA15119@duna207.danubius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111121128.MAA15119@duna207.danubius>; from Miklos.Szeredi@eth.ericsson.se on Mon, Nov 12, 2001 at 12:28:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
>     - Thin layer in kernel. Minimal caching, predictable behavior.

Minimal caching?  I would hope for maximal caching, for when userspace
is able to say "yes the page you have is still valid".  Preferably
without a round trip to userspace for every page.

-- Jamie
