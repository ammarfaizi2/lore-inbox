Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUI2KqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUI2KqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 06:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268304AbUI2KqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 06:46:17 -0400
Received: from smtpout1.uol.com.br ([200.221.11.54]:16570 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S268301AbUI2KpG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 06:45:06 -0400
Date: Wed, 29 Sep 2004 07:40:49 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Joshua Ross <jrxr@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Data corruption on IDE disk via USB.
Message-ID: <20040929104049.GA3816@ime.usp.br>
Mail-Followup-To: Joshua Ross <jrxr@softhome.net>,
	linux-kernel@vger.kernel.org
References: <20040929171744.0b3a0773.jrxr@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040929171744.0b3a0773.jrxr@softhome.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 29 2004, Joshua Ross wrote:
> I have an external hard drive with an IDE interface.  This goes through
> a USB2.0-IDE adapter.  I'm getting silent corruption of data when
> copying big files to the drive, but not consistently.  The partition was
> originally ext3, but I'm now mounting it ext2 and sync.  Still getting
> the corruption.  

Which kind of corruption are you seeing? I was seeing some non-silent
problems with an IDE drive connected in a Firewire/USB2 enclosure.

Using it with my iBook on MacOS X is perfectly ok, but trying to use the
drive connected to a USB 1.1 desktop (my main computer) under Linux also
presented problems when copying a large file (one of Dijkstra's talks).

This error, differently from yours, was consistent and produced a lot of
messages regarding the media of the "USB drive" being removed (!) from the
system (while it obviously wasn't) and it left me with corrupted
filesystems (I tried ext2/3, vfat and hfsplus, which are things that both
MacOS X and Linux can read).

I usually tried to use rsync to copy the files, but, if I remember
correctly, the problem would also manifest when using plain cp.



-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
