Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSHXBUg>; Fri, 23 Aug 2002 21:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSHXBUg>; Fri, 23 Aug 2002 21:20:36 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:16354 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315198AbSHXBUf>; Fri, 23 Aug 2002 21:20:35 -0400
Date: Fri, 23 Aug 2002 20:24:46 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Daniel I. Applebaum" <kernel@danapple.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 build failure 
In-Reply-To: <20020824011842.A46E810B54@wotke.danapple.com>
Message-ID: <Pine.LNX.4.44.0208232023400.22497-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Daniel I. Applebaum wrote:

> % gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.0)
> % rpm -qa | grep gcc
> gcc-c++-2.96-54
> kgcc-1.1.2-40
> gcc-2.96-54
> gcc-g77-2.96-54
> 
> Do I really need to change to 2.95.3?

No, but you should try to update to the latest 2.96 version (initial 
versions are known to be buggy, not sure if yours is any of those, 
though). The latest for Redhat 7.0 seem to be

ncftp ...updates/7.0/en/os/i386 > ls gcc*
gcc-2.96-85.i386.rpm                   gcc-g77-2.96-85.i386.rpm
gcc-c++-2.96-85.i386.rpm               gcc-java-2.96-85.i386.rpm
gcc-chill-2.96-85.i386.rpm             gcc-objc-2.96-85.i386.rpm

--Kai


