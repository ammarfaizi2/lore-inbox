Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWAWQqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWAWQqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWAWQqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:46:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:39143 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932442AbWAWQqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:46:48 -0500
Message-ID: <43D50875.7070101@suse.de>
Date: Mon, 23 Jan 2006 17:46:45 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild: problems with separate src/obj trees
References: <43D4D708.2050802@suse.de> <dr2rtq$c4$1@sea.gmane.org>
In-Reply-To: <dr2rtq$c4$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> master-xen kraxel ~/objtree/vanilla-2.6.16-pre-um# make ARCH=um
>> gmake -C /home/kraxel/scratch/vanilla-2.6.16-pre
>> O=/home/kraxel/objtree/vanilla-2.6.16-pre-um
>>   SYMLINK arch/um/include/kern_constants.h
>> ln: creating symbolic link `arch/um/include/kern_constants.h' to
>> `../../../include/asm-um/asm-offsets.h': No such file or directory
>> gmake[2]: *** [arch/um/include/kern_constants.h] Error 1
>> gmake[1]: *** [cdbuilddir] Error 2
>> gmake: *** [all] Error 2

> There was a recen thread about these... let me see:
> Look for "[PATCH 2/2] kbuild: fix make -jN with multiple targets with make
> O=..." from Sam Ravnborg on 2006-01-16

Ok, the .kernelrelease issue is fixed meanwhile, I still see the UML
build failure though.  That triggers also without "make -j", so it is
probably a different bug ...

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
