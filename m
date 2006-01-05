Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWAEP0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWAEP0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWAEP0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:26:15 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:57995 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932068AbWAEP0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:26:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UqPkmumfFttZ7guw2KNIxr5A0LU3w8gZjauZJpqWs8txcTWgg/gM2qrvaAOIBR0VxbxGxRw0BwyICjOumgHMcnV6JShwS+kZFK8tjqOm5PPCLA9dJZi5ogPgUn/S5xRcsuKLc9AaZpY+crDMh8KgrUrFLXmnmaIfcA8K6KPy9Kw=
Message-ID: <43BD3AAC.9000104@gmail.com>
Date: Thu, 05 Jan 2006 20:26:36 +0500
From: "Alexander E. Patrakov" <patrakov@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Olivier Galibert <galibert@pobox.com>,
       Heikki Orsila <shd@modeemi.cs.tut.fi>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi> <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz> <20060105145101.GB28611@dspnet.fr.eu.org>
In-Reply-To: <20060105145101.GB28611@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:

> Make simple things simple, guys.

Sorry for hijacking the thread, but it is very true. ALSA is just too 
flexible so that the ALSA equivalent (if it indeed exists) of 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=339951 cannot be fixed. 
OSS allows specification of device name, and one can set up udev rules 
so that e.g. /dev/dsp-creative it is always a symlink to a SB PCI sound 
card and /dev/dsp-fortemedia is for FM801. Then one can tell xine to 
play sound through /dev/dsp-fortemedia. ALSA accepts only numbers in its 
plughw:x,y,z notation, and applications are unfixable when kernel device 
numbers become random.

-- 
Alexander E. Patrakov
