Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSKTVjp>; Wed, 20 Nov 2002 16:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSKTVjp>; Wed, 20 Nov 2002 16:39:45 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:46098 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S261642AbSKTVjo>;
	Wed, 20 Nov 2002 16:39:44 -0500
Message-ID: <3DDBF02D.4060005@iinet.net.au>
Date: Thu, 21 Nov 2002 07:27:25 +1100
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix Seeger <felix.seeger@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 QM_MODULES: Function not implemented
References: <200211202004.20261.felix.seeger@gmx.de>
In-Reply-To: <200211202004.20261.felix.seeger@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Seeger wrote:

  > -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
  >
  > Hello
  >
  > I compiled 2.5.48 and now all the files like modules.dep in
  > /lib/modules are away.
  >
  > I can't load a module, I get this: modprobe: Can't open dependencies
  > file /lib/modules/2.5.48/modules.dep ...
  >
  > depmod: QM_MODULES: Function not implemented
  >
  > I enabled all option in the module config.

You need Rusty's modutils from here:
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/module-init-tools-0.7.tar.bz2

And a patch to kernel/module.c (so you don't get the "Cannot allocate
memory" message...:
http://groups.google.com/groups?dq=&hl=en&lr=&ie=UTF-8&selm=20021120125211.GA446%40apocalipsis




