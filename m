Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268470AbUJUNJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268470AbUJUNJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUJUNIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:08:25 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:36247 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S268655AbUJUNCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:02:09 -0400
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3: `risc_code_addr01' multiple definition
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<20041007165849.GA4493@stusta.de> <1097170149.12535.27.camel@praka>
	<1097171420.1718.332.camel@mulgrave>
From: Jes Sorensen <jes@wildopensource.com>
Date: 21 Oct 2004 09:02:07 -0400
In-Reply-To: <1097171420.1718.332.camel@mulgrave>
Message-ID: <yq08ya0rzqo.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Bottomley <James.Bottomley@SteelEye.com> writes:

James> On Thu, 2004-10-07 at 12:29, Andrew Vasquez wrote:
>> Hmm, seems the additional 1040 support in qla1280.c is causing name
>> clashes with the firmware image in qlogicfc_asm.c.  Try out the
>> attached patch (not tested) which provides the 1040 firmware image
>> unique variable names.
>> 
>> Looks like there would be some name clashes in qlogicfc and
>> qlogicisp.

James> Is there any reason for these firmware image pointers not to be
James> static?  At least for these drivers which are single files.

I was just thinking the same thing - 2 weeks after everybody else ;-)

You won't see me complaining about a patch doing this for the qla1280
driver.

Cheers,
Jes
