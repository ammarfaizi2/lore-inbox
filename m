Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270487AbTGVKbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270493AbTGVKbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:31:19 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:32221 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270487AbTGVKbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:31:18 -0400
Date: Tue, 22 Jul 2003 11:09:37 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB flash disk on 2 machines exclusiv
Message-ID: <20030722110937.P639@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.53.0307221026120.2214@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.53.0307221026120.2214@hosting.rdsbv.ro>; from util@deuroconsult.ro on Tue, Jul 22, 2003 at 10:31:15AM +0300
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19euez-0003D8-00*HesRnILJBjE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Tue, Jul 22, 2003 at 10:31:15AM +0300, Catalin BOIE wrote:
> The disk is recognized by both machines as sda1.
> 
> I do a mkreiserfs /dev/sda1, mount it and everything works on machine 1.
> If I go to machine 2, the kernel cannot recognise a valid reiserfs on the
> flash. If I do a mkreiserfs, I can work with it, but when I move to
> machine 1, same problem (reiserfs not recognized).

Did you try other file systems? Does it work with other Linux
file systems like ext2 or ext3? Does it work with VFAT?

Please try these to tell, whether it's FS specific.

Thanks & Regards

Ingo Oeser, just trying to be helpful
