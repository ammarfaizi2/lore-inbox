Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbTCJUWt>; Mon, 10 Mar 2003 15:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261423AbTCJUWt>; Mon, 10 Mar 2003 15:22:49 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:499 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261410AbTCJUWs> convert rfc822-to-8bit; Mon, 10 Mar 2003 15:22:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: Daniel Egger <degger@fhm.edu>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Date: Mon, 10 Mar 2003 21:33:25 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <m1adg4kbjn.fsf@frodo.biederman.org> <1047219550.4102.6.camel@sonja>
In-Reply-To: <1047219550.4102.6.camel@sonja>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303102133.25790.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sunday 09 March 2003 15:19, Daniel Egger wrote:
> Am Son, 2003-03-09 um 12.46 schrieb Eric W. Biederman:
>
> > Etherboot can load to any address < 4GB and can jump to a 32bit entry
> > point.  It's not rocket science or magic just good open source code.
>
> Maybe etherboot isn't the culprit here, but mknbi won't let me
> create bigger tagged boot kernels.

The biggest bootimage I'm using here is (SuSE 8.2b3 Inst. Kernel+initrd):
-r--r--r--    1 nobody   nogroup   6009856 Mar  6 10:07 bootimage-ziggy
created with mknbi-linux V1.2, so this isn't really the problem.
I'm also using ~4MB sized dos boot images (PQMagic, BIOS updates) without
problems. Don't try this with floppies...

Etherboot is simply pure fun and saved my life a couple of times ;-)

Thanks, Eric!

Bye,
Pete
