Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289186AbSAIHYT>; Wed, 9 Jan 2002 02:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289187AbSAIHYK>; Wed, 9 Jan 2002 02:24:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50954 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289186AbSAIHX4>; Wed, 9 Jan 2002 02:23:56 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Date: 8 Jan 2002 23:23:48 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1gr64$n4g$1@cesium.transmeta.com>
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <20020109043446.GB17655@kroah.com> <20020109061037.GB18024@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020109061037.GB18024@kroah.com>
By author:    Greg KH <greg@kroah.com>
In newsgroup: linux.dev.kernel
>
> On Tue, Jan 08, 2002 at 08:34:47PM -0800, Greg KH wrote:
> > 
> > Here's what I want to have in my initramfs:
> > 	- /sbin/hotplug
> > 	- /sbin/modprobe
> > 	- modules.dep (needed for modprobe, but is a text file)
> 
> Forgot the modules themselves.  That would be helpful...
> 

Sure, but those are data files as far as the (k)libc is concerned.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
