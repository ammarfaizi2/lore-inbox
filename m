Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUJGSBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUJGSBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUJGSAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:00:11 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:32400 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267469AbUJGRvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:51:54 -0400
Subject: Re: 2.6.9-rc3-mm3: `risc_code_addr01' multiple definition
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097170149.12535.27.camel@praka>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<20041007165849.GA4493@stusta.de>  <1097170149.12535.27.camel@praka>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 07 Oct 2004 12:50:14 -0500
Message-Id: <1097171420.1718.332.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 12:29, Andrew Vasquez wrote:
> Hmm, seems the additional 1040 support in qla1280.c is causing name
> clashes with the firmware image in qlogicfc_asm.c.  Try out the attached
> patch (not tested) which provides the 1040 firmware image unique
> variable names.
> 
> Looks like there would be some name clashes in qlogicfc and qlogicisp.

Is there any reason for these firmware image pointers not to be static? 
At least for these drivers which are single files.

James


