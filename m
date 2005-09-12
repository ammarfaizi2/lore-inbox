Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVILESd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVILESd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 00:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVILESd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 00:18:33 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:40335 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S1751156AbVILESd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 00:18:33 -0400
Message-ID: <43250150.20308@metaparadigm.com>
Date: Mon, 12 Sep 2005 12:17:20 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Tilley <rtilley@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Universal method to start a script at boot
References: <1126462329.4324737923c2d@wmtest.cc.vt.edu> <1126462467.43247403c2e1c@wmtest.cc.vt.edu>
In-Reply-To: <1126462467.43247403c2e1c@wmtest.cc.vt.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Tilley wrote:

>This is off-topic and I apologize. However, I think some here could answer
>this.
>
>  
>
>>Is there a standard way to start a script or program at boot that will work
>>on any Linux kernel/distro no matter which init system is being used or how it
>>has been configured? Probably not, but I thought someone here could possibly
>>answer this.
>>    
>>

You could use the LSB conforming method of writing and installing
an init script:

http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html
http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptfunc.html
http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initscrcomconv.html
http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initsrcinstrm.html

Most of the main distros support this (Fedora, RHEL, SuSE,
Mandriva, Debian, ...). Not to say all of them ship with the
LSB support packages installed by default. Some do some don't.

On Debian I need to do an "apt-get install lsb".

~mc

