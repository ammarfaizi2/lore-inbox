Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262150AbSJNT7p>; Mon, 14 Oct 2002 15:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbSJNT7p>; Mon, 14 Oct 2002 15:59:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61340 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262151AbSJNT7l>;
	Mon, 14 Oct 2002 15:59:41 -0400
Date: Mon, 14 Oct 2002 12:58:29 -0700 (PDT)
Message-Id: <20021014.125829.01014301.davem@redhat.com>
To: perex@perex.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: ALSA update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0210142139080.7202-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.33.0210142139080.7202-100000@pnote.perex-int.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This breaks the build on sparc64:

sound/core/ioctl32/ioctl32.h:95: parse error before `if'
sound/core/ioctl32/ioctl32.h:99: parse error before `sizeof'
sound/core/ioctl32/ioctl32.h:99: `data32' undeclared here (not in a function)
sound/core/ioctl32/ioctl32.h:99: warning: type defaults to `int' in declaration of `CVT_s\ndrv_type'
sound/core/ioctl32/ioctl32.h:99: warning: function declaration isn't a prototype
sound/core/ioctl32/ioctl32.h:99: warning: data definition has no type or storage class
sound/core/ioctl32/ioctl32.h:99: parse error before `}'
sound/core/ioctl32/ioctl32.h:99: warning: type defaults to `int' in declaration of `oldse\g'
sound/core/ioctl32/ioctl32.h:99: incompatible types in initialization
sound/core/ioctl32/ioctl32.h:99: initializer element is not constant
sound/core/ioctl32/ioctl32.h:99: warning: data definition has no type or storage class
sound/core/ioctl32/ioctl32.h:99: parse error before `do'
sound/core/ioctl32/ioctl32.h:99: warning: type defaults to `int' in declaration of `err'
sound/core/ioctl32/ioctl32.h:99: `file' undeclared here (not in a function)
sound/core/ioctl32/ioctl32.h:99: `file' undeclared here (not in a function)
sound/core/ioctl32/ioctl32.h:99: `file' undeclared here (not in a function)
sound/core/ioctl32/ioctl32.h:99: `native_ctl' undeclared here (not in a function)
sound/core/ioctl32/ioctl32.h:99: `data' undeclared here (not in a function)
sound/core/ioctl32/ioctl32.h:99: warning: data definition has no type or storage class
sound/core/ioctl32/ioctl32.h:99: parse error before `if'
sound/core/ioctl32/ioctl32.h:99: warning: type defaults to `int' in declaration of `err'
sound/core/ioctl32/ioctl32.h:99: redefinition of `err'
sound/core/ioctl32/ioctl32.h:99: `err' previously defined here
sound/core/ioctl32/ioctl32.h:99: warning: data definition has no type or storage class
sound/core/ioctl32/ioctl32.h:99: parse error before `if'
sound/core/ioctl32/ioctl32.h:99: `data32' undeclared here (not in a function)
sound/core/ioctl32/ioctl32.h:99: warning: type defaults to `int' in declaration of `CVT_s\ndrv_type'
sound/core/ioctl32/ioctl32.h:99: warning: function declaration isn't a prototype
sound/core/ioctl32/ioctl32.h:99: warning: data definition has no type or storage class
sound/core/ioctl32/ioctl32.h:99: parse error before `}'
sound/core/ioctl32/ioctl32.h:136: warning: This file contains more `}'s than `{'s.
sound/core/ioctl32/ioctl32.c: In function `_snd_ioctl32_ctl_elem_value':
sound/core/ioctl32/ioctl32.c:275: warning: implicit declaration of function `kmalloc_Rsmp\_6f6c1cf7'
sound/core/ioctl32/ioctl32.c:275: `GFP_KERNEL' undeclared (first use in this function)
sound/core/ioctl32/ioctl32.c:275: (Each undeclared identifier is reported only once
sound/core/ioctl32/ioctl32.c:275: for each function it appears in.)
sound/core/ioctl32/ioctl32.c:275: warning: assignment makes pointer from integer without \a cast
sound/core/ioctl32/ioctl32.c:276: warning: assignment makes pointer from integer without \a cast
sound/core/ioctl32/ioctl32.c:290: request for member `value' in something not a structure\ or union
sound/core/ioctl32/ioctl32.c:296: request for member `indirect' in something not a struct\ure or union
sound/core/ioctl32/ioctl32.c:331: request for member `indirect' in something not a struct\ure or union
sound/core/ioctl32/ioctl32.c:362: warning: implicit declaration of function `kfree_Rsmp_0\37a0cba'
