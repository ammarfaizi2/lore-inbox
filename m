Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSLUS5D>; Sat, 21 Dec 2002 13:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSLUS5D>; Sat, 21 Dec 2002 13:57:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:43276 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263760AbSLUS5C>;
	Sat, 21 Dec 2002 13:57:02 -0500
Date: Sat, 21 Dec 2002 20:05:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Sampson Fung <sampson@attglobal.net>
Cc: "'John Bradford'" <john@grabjohn.com>,
       "'Sampson Fung'" <sampson.fung@attglobal.net>,
       linux-kernel@vger.kernel.org
Subject: Re: How to help new comers trying the v2.5x series kernels.
Message-ID: <20021221190503.GA1508@mars.ravnborg.org>
Mail-Followup-To: Sampson Fung <sampson@attglobal.net>,
	'John Bradford' <john@grabjohn.com>,
	'Sampson Fung' <sampson.fung@attglobal.net>,
	linux-kernel@vger.kernel.org
References: <200212211816.gBLIG3NV000880@darkstar.example.net> <000b01c2a91f$01324ff0$0100a8c0@noelpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c2a91f$01324ff0$0100a8c0@noelpc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 02:30:13AM +0800, Sampson Fung wrote:
> Where is the default .config?  I am eager to have a try.

Try "make help"

That will teach you about:
make defconfig		<= Linus's own configuration (well more or less)
make allnoconfig	<= Minimal config, but often it does not compile

The reason "allnoconfig" often fails, is that for example some part of
the kernel may assume networking to be enabled. And in general
only few people try "allnoconfig", because the resulting kernel is
seldom of any use.

	Sam
