Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281157AbRK3XGI>; Fri, 30 Nov 2001 18:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281103AbRK3XF6>; Fri, 30 Nov 2001 18:05:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26866
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281157AbRK3XFn>; Fri, 30 Nov 2001 18:05:43 -0500
Date: Fri, 30 Nov 2001 15:05:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Sven Koch <haegar@sdinet.de>
Cc: Mauricio Culibrk <mauricio@infohit.si>, linux-kernel@vger.kernel.org
Subject: Re: Device (LAN Cards) Naming
Message-ID: <20011130150536.E504@mikef-linux.matchmail.com>
Mail-Followup-To: Sven Koch <haegar@sdinet.de>,
	Mauricio Culibrk <mauricio@infohit.si>,
	linux-kernel@vger.kernel.org
In-Reply-To: <A57F0FE23B31C14E84E38657C03A44982BB3@Godzilla> <Pine.LNX.4.40.0111302055540.7425-100000@space.comunit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0111302055540.7425-100000@space.comunit.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 08:57:28PM +0100, Sven Koch wrote:
> On Fri, 30 Nov 2001, Mauricio Culibrk wrote:
> 
> > Is it possible to define a name for each interface instead of having
> > eth0, eth1 etc?
> 
> ip link set eth0 down
> ip link set eth0 name buggy
> ip link set buggy up
> 

Ohh, nice!

Though I've gotten used to ethX, I'm sure this can help make scripts a bit
easier to read.

Does the new name work with ifconfig?
