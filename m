Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265290AbRGJIDw>; Tue, 10 Jul 2001 04:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265592AbRGJIDm>; Tue, 10 Jul 2001 04:03:42 -0400
Received: from L0184P16.dipool.highway.telekom.at ([62.46.86.240]:64934 "EHLO
	mannix") by vger.kernel.org with ESMTP id <S265290AbRGJIDc>;
	Tue, 10 Jul 2001 04:03:32 -0400
Date: Tue, 10 Jul 2001 10:07:45 +0200
To: sendhil kumar <hello_linux@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Regarding the make module_install.
Message-ID: <20010710100745.A29258@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010709234259.42707.qmail@web14903.mail.yahoo.com>
User-Agent: Mutt/1.3.18i
From: Alexander Griesser <tuxx@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 04:42:59PM -0700, you wrote:
> Can any one update me about, what make module and make
> module_install do?

That's a FAQ!
make modules compiles the modules
make modules_install copies the modules to /lib/modules/$(uname -r)

> What is the difference between the insmod command and
> module_install?

The two things are completely different.
insmod/modprobe is a tool for loading modules dynamically into a running
kernel and modules_install is a makefile-target, user for copying the
precompiled modules to a certain destination.

Please don't post such questions in here, check for a local linux
newsgroup or discussionforum.

regards, alexx
-- 
|    .-.    |   CCNAIA Alexander Griesser <tuxx@aon.at>  |   .''`.  |
|    /v\    |  http://www.tuxx-home.at -=- ICQ:63180135  |  : :' :  |
|  /(   )\  |    echo "K..?f{1,2}e[nr]böck" >>~/.score   |  `. `'   |
|   ^^ ^^   |    Linux Version 2.4.6 - Debian Unstable   |    `-    |
