Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWJJLmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWJJLmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 07:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbWJJLmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 07:42:23 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:41345 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030178AbWJJLmW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 07:42:22 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Tue, 10 Oct 2006 13:42:16 +0200
User-Agent: KMail/1.9.4
Cc: Andreas Schwab <schwab@suse.de>, David Howells <dhowells@redhat.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Matthew Wilcox <matthew@wil.cx>,
       torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr> <je4pudns4g.fsf@sykes.suse.de> <Pine.LNX.4.61.0610101140490.19891@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610101140490.19891@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101342.18934.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 11:41, Jan Engelhardt wrote:
> >The compiler is not allowed to define uint32_t without including
> ><stdint.h> first.
> 
> Well no problem, stdint.h may just have
> 
> typedef __secret_compiler_provided_uint32_t uint32_t;
> 

But it doesn't, and there's nothing the kernel can do about this
for existing gcc versions.

	Arnd <><
