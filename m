Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSCHXAJ>; Fri, 8 Mar 2002 18:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292092AbSCHW7t>; Fri, 8 Mar 2002 17:59:49 -0500
Received: from jhuml3.jhu.edu ([128.220.2.66]:57301 "EHLO jhuml3.jhu.edu")
	by vger.kernel.org with ESMTP id <S292150AbSCHW7j>;
	Fri, 8 Mar 2002 17:59:39 -0500
Date: Fri, 08 Mar 2002 18:00:40 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: PnP BIOS driver status
To: linux-kernel@vger.kernel.org
Message-id: <1015628440.14518.212.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple people have asked me about the status of the 
PnP BIOS driver, so I thought I'd post an update. 

History: During the pre-Tosatti 2.4-ac series the driver was 
hammered into a reliable form.  However it never entered the 
mainline kernel series. 

The driver was then stripped down to the core functionality 
required to make the lspnp and setpnp utilities work. 
pnpbios_register_driver() and pnpbios_unregister_driver() are 
still there but aren't used by anything.  Additional /proc/ 
interface files were then added to allow reading of ESCD info. 

The latest version of the driver seems nice 'n' stable and can 
be found in Alan's latest 2.4 patches. 

Current 2.5 kernels also contain the driver, but it's a bit out 
of date.  There's a patch in 2.5-dj but that's also out of date. 
("Out of date" here means "missing new features and some 
cleanups".)  Once DJ releases a 2.5.6-dj I'll send him a patch 
to bring his tree up to date.  Then he can pass it on to Linus. 

-- 
Thomas Hood

