Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbTKMUKC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 15:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTKMUKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 15:10:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26898 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264422AbTKMUJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 15:09:59 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PCI: device 00:09.0 has unknown header type 04, ignoring.  What's that?
Date: 13 Nov 2003 12:09:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bp0oe8$eps$1@cesium.transmeta.com>
References: <200311132040.23582.michael.born@stud.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200311132040.23582.michael.born@stud.uni-hannover.de>
By author:    Michael Born <michael.born@stud.uni-hannover.de>
In newsgroup: linux.dev.kernel
> 
> What is "unknown header type 04" ?
> How can I know what's wrong with this card?
> 

There is no header type 4 (type 0 and 1 exist, but not 4.)  That means
your card is not compliant with the PCI specification, and any attempt
at accessing this device is based on guesswork.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
