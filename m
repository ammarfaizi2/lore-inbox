Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSFTV0C>; Thu, 20 Jun 2002 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSFTV0B>; Thu, 20 Jun 2002 17:26:01 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:44213
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S315525AbSFTV0A>; Thu, 20 Jun 2002 17:26:00 -0400
Date: Thu, 20 Jun 2002 17:32:59 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with raid0 with 2.4.19-pre10-ac2
Message-ID: <20020620173259.A16339@animx.eu.org>
References: <20020620085208.A7666@coredump.electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20020620085208.A7666@coredump.electro-mechanical.com>; from William Thompson on Thu, Jun 20, 2002 at 08:52:08AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I create a 2 disk raid 0.  I stop it and attempt to start it again and it
> doesn't start.  It apparently doesn't write out the persistant super block. 
> I did not reboot when i did this.  I don't have a transcript of what
> happened.  I can get it later if it's needed.
> 
> Who writes the superblock anyway?  mkraid or the kernel driver?

Forget this, the problem was the order of /etc/raidtab.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
