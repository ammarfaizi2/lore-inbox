Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUJRE4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUJRE4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 00:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUJRE4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 00:56:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:35759 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264113AbUJRE4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 00:56:04 -0400
Date: Mon, 18 Oct 2004 06:56:03 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow kernel compile with native ppc64 compiler
Message-ID: <20041018045603.GA8500@suse.de>
References: <20041017185557.GA9619@suse.de> <16754.59442.992185.715900@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16754.59442.992185.715900@cargo.ozlabs.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 18, Paul Mackerras wrote:

> Olaf Hering writes:
> 
> > The zImage is a 32bit binary, but a native powerpc64-linux gcc will
> > produce 64bit objects in arch/ppc64/boot.
> > This patch fixes it.
> 
> ... and breaks the compile on older toolchains that don't understand
> -m32.  We need to make the -m32 conditional on HAS_BIARCH as defined
> in arch/ppc64/Makefile.

how old?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
