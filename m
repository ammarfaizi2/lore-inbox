Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUFPQHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUFPQHC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUFPQHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:07:02 -0400
Received: from pat.uio.no ([129.240.130.16]:52126 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264101AbUFPQFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:05:45 -0400
To: linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] atime on devices
X-Draft-From: ("fa.linux.kernel" 488302)
References: <fa.j3j5n9a.12n2f8g@ifi.uio.no> <fa.gbo3vfu.1e429hc@ifi.uio.no>
From: Sturle Sunde <sturle.sunde@usit.uio.no>
Organization: Universitetets senter for informasjonsteknologi
Date: Wed, 16 Jun 2004 17:30:34 +0200
In-Reply-To: <fa.gbo3vfu.1e429hc@ifi.uio.no> (Jan-Benedict Glaw's message of "Wed, 16 Jun 2004 13:15:50 GMT")
Message-ID: <riqpt7z8qqt.fsf@maggie.uio.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:
> On Wed, 2004-06-09 16:20:17 +0200, Sturle Sunde <sturle.sunde@usit.uio.no>
> wrote in message <riqhdtkke3i.fsf@maggie.uio.no>:
>> Some software use access times on device files to check if there is
>> mouse or keyboard activity on the console.  This used to work in old
>> kernels, or perhaps it was old hardware, but not any more.  Google
>> didn't find any other portable ways of checking for mouse or keyboard
>> activity without accessing the X11 display.
> open() /dev/input/evdev* and select() on them?

Requires root privileges, and you can't see how long the device was
idle before you did select.

-- 
Sturle
~~~~~
