Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbTAFO1H>; Mon, 6 Jan 2003 09:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbTAFO1H>; Mon, 6 Jan 2003 09:27:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56452
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265568AbTAFO1G>; Mon, 6 Jan 2003 09:27:06 -0500
Subject: Re: [TRIVIAL] [PATCH 1 of 3] Fix errors making Docbook
	documentation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Trivial Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030106041150.EBCA42C26D@lists.samba.org>
References: <20030106041150.EBCA42C26D@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041866409.17472.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 15:20:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 03:47, Rusty Trivial Russell wrote:
> From:  Craig Wilkie <craig@homerjay.homelinux.org>
>   Documentation/Docbook/kernel-api.tmpl - Remove references to source 
>   files which do not contain kernel-doc comments, which caused "errors" in 
>   the generated documentation.

Please don't do this. The proper fixes already exist just never got
merged. Also documentation exists for those files and isnt merged. The
docbook is not the problem, the pile of other missing bits is

Grab the docbook for those files from 2.4 and also the changes to the
docbook generator

