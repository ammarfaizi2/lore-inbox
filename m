Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTKZUk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTKZUk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:40:28 -0500
Received: from pop.gmx.net ([213.165.64.20]:44739 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264329AbTKZUkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:40:24 -0500
X-Authenticated: #524548
From: rgx <rgx@gmx.de>
To: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
Subject: Re: kernel 2.4-22 won't compile...
Date: Wed, 26 Nov 2003 21:40:15 +0100
User-Agent: KMail/1.5.4
References: <200311261734.23177.rgx@gmx.de> <200311261935.03860.rgx@gmx.de> <1069873394.25657.28.camel@tweedy.ksc.nasa.gov>
In-Reply-To: <1069873394.25657.28.camel@tweedy.ksc.nasa.gov>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311262140.15049.rgx@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Chiodini schrieb am Mittwoch, 26. November 2003 20:03:
...
> See include/linux/autoconf.h: around line 2167, my 2.4.20 source:
>
> #define CONFIG_NLS_DEFAULT "iso8859-1"
>
> Which corresponds to its usage in
> /data/src/linux-2.4.22/fs/fat/inode.c, char *.

here we go! seems as we are approaching the core of all trouble: my  
include/linux/autoconf.h lacks the corresponding entry. How big is your 
autoconf.h? Mine is about 19k. For now, I'll add that line and go 
on ...
>
> Is this a ix86 kernel?
it is (amd 1800+)

thanx!
ralf
>
> Bob..

