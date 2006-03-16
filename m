Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbWCPUmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWCPUmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWCPUmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:42:45 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:42777 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932726AbWCPUmo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:42:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ilr2U2W63d9lnodx6TAk2tdv8gY4DdqUqRt/NGNj4642KxeOxwZgMwYsDti2MIizrfavS+BtOd0QRkb9ibLZWRarY4ZT9qz/ehHhm7fllxrPJKtCGFSJNYfMBZTpHLkg2jyuj5xgbIjxqZjz0ToymRQ/5/VZUfP83xWpdl7kc80=
Message-ID: <a71bd89a0603161242i5dbe0d1fk7f2c028027dae2e6@mail.gmail.com>
Date: Thu, 16 Mar 2006 12:42:42 -0800
From: "Dan Kegel" <dank@kegel.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: [llh-announce] [ANNOUNCE] linux-libc-headers dead
Cc: "Nigel Kukard" <nkukard@lbsd.net>, "Mariusz Mazur" <mmazur@kernel.pl>,
       llh-announce@lists.pld-linux.org, VMiklos <vmiklos@frugalware.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603162118080.11776@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603141619.36609.mmazur@kernel.pl>
	 <20060316083716.jnfgt8wilcgoo4ws@webmail.lbsd.net>
	 <Pine.LNX.4.61.0603162118080.11776@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> Some linux distributions (I know of Novell who do it for SUSE Linux)
> seem to roll their own thing AFAICS. The glibc.src.rpm from them contains
> a userspacified copy of the kernel headers.

Yep.  Red Hat does, too.  They had to, since there wasn't
a linux-libc-headers project when they started.

Maybe the way to move forward is to see if we can
get the linux-libc-headers accepted as is into
the kernel.org tree in a userspace-include directory,
then maintain it there.
- Dan

--
Wine for Windows ISVs: http://kegel.com/wine/isv
