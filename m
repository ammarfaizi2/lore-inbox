Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVFUOV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVFUOV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVFUOUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:20:49 -0400
Received: from smtp04.auna.com ([62.81.186.14]:65430 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S262077AbVFUOT1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:19:27 -0400
Date: Tue, 21 Jun 2005 14:19:26 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, kbuild-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
References: <42B7F740.6000807@drzeus.cx>
	<Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx>
	<Pine.LNX.4.61.0506211451040.3728@scrub.home> <42B80F40.8000609@drzeus.cx>
	<Pine.LNX.4.61.0506211515210.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0506211515210.3728@scrub.home> (from
	zippel@linux-m68k.org on Tue Jun 21 15:20:01 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119363566l.11384l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Tue, 21 Jun 2005 16:19:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.21, Roman Zippel wrote:
> Hi,
> 
> On Tue, 21 Jun 2005, Pierre Ossman wrote:
> 
> > Should I extract the changes for bkbits and make a reversed patch?
> 
> No, go through the warnings, analyze each one and choose an appropriate 
> solution. You might want to keep notes, which you can post with the 
> changelogs, so one can reproduce, why a certain change was done.
> 

I started doing that, and the more warnings are related to strxxx functions.
They are defined as receiving 'char *' pointers, I do not know why someone
started to fill the sources with 'signed char *' for text strings...

I did not finish the cleaup due to lack of time, but I was planning to
continue...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


