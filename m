Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274177AbRI3UxJ>; Sun, 30 Sep 2001 16:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274178AbRI3Uw7>; Sun, 30 Sep 2001 16:52:59 -0400
Received: from weta.f00f.org ([203.167.249.89]:12950 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S274177AbRI3Uws>;
	Sun, 30 Sep 2001 16:52:48 -0400
Date: Mon, 1 Oct 2001 08:53:54 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp_v4_get_port() and ephemeral ports
Message-ID: <20011001085354.A25723@weta.f00f.org>
In-Reply-To: <3BB75EB4.3268D3FC@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB75EB4.3268D3FC@kegel.com>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 11:04:36AM -0700, Dan Kegel wrote:

    It's tempting to patch tcp_v4_get_port() to check sk->rcv_saddr,
    and if it's nonzero, allow the same ephemeral port number to be
    reused on different interfaces.  Kinda like this (untested):

Have the application do this for you.




  --cw
