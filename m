Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSBZPNb>; Tue, 26 Feb 2002 10:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288921AbSBZPNW>; Tue, 26 Feb 2002 10:13:22 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:42212 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S288248AbSBZPNK>; Tue, 26 Feb 2002 10:13:10 -0500
Date: Tue, 26 Feb 2002 16:12:38 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Daniel Shane <daniel.shane@eicon.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI driver in userspace
Message-ID: <20020226151226.GB5337@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <D8E12241B029D411A3A300805FE6A2B9025761A9@montreal.eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8E12241B029D411A3A300805FE6A2B9025761A9@montreal.eicon.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 09:55:48AM -0500, Daniel Shane wrote:

> I'm looking for an example of userspace PCI driver, does anyone know where I
> could find one? (Probably not in the kernel source tree, obviously).

There are probably better examples than mines, but you can still
look at the Andrew Tridgell's 'capture' application which drives the
PCI Motion Eye Camera device (and compare with drivers/media/video/meye.c):
	http://samba.org/picturebook/

You'll find in it quite a number of features, including i/o memory
mapping, i/o port access, etc.

Of course, one could also direct you to the XFree source code... :-)

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
