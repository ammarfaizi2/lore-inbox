Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTEPGEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 02:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbTEPGEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 02:04:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:45903 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264303AbTEPGEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 02:04:44 -0400
Date: Fri, 16 May 2003 08:17:29 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: <esp@pyroshells.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: FAT32 problems with kernel 2.4.19
Message-Id: <20030516081729.0b441fff.gigerstyle@gmx.ch>
In-Reply-To: <23493.65.122.196.250.1053063209.squirrel@mail.webhaste.com>
References: <23493.65.122.196.250.1053063209.squirrel@mail.webhaste.com>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/sda1            /windows/D           vfat
> users,gid=users,umask=0002,iocharset=iso8859-1,code=437 0 0

try with 
/dev/sda1   /windows/D  vfat  users,exec,gid=users,umask=0002,iocharset=iso8859-1,code=437 0 0

greets

Marc
