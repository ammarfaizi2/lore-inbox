Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318585AbSHGQWc>; Wed, 7 Aug 2002 12:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318588AbSHGQWc>; Wed, 7 Aug 2002 12:22:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1531 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318585AbSHGQWb>; Wed, 7 Aug 2002 12:22:31 -0400
Subject: Re: UNIX domain socket hanging around when not closed
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20020807155606.GH32427@mea-ext.zmailer.org>
References: <20020807153251.GD27745@vagabond> 
	<20020807155606.GH32427@mea-ext.zmailer.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 18:45:42 +0100
Message-Id: <1028742342.18478.321.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 16:56, Matti Aarnio wrote:
>       - There could pre-exist the named socket (at a R/O
>         filesystem), and no new name needs to be allocated
>         in the filesystem for it.
> 
>       - The entire named entity would not be allowed to
>         exist purely in VFS space, that is: creation wise
>         the permission verification could ignore location
>         directory being on a read/only file system, and
>         just use directory permissions.  (Questions about
>         memory expenditure, etc.  all kinds of trade-offs.)

Linux has a non file system name space for AF_UNIX sockets too. But its
a Linux extension

