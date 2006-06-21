Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWFUTk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWFUTk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWFUTk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:40:27 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:4270 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932705AbWFUTkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:40:24 -0400
Date: Wed, 21 Jun 2006 21:39:32 +0200
From: Mattia Dongili <malattia@linux.it>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fs/binfmt_aout.o, Error: suffix or operands invalid for `cmp' [was Re: 2.6.17-mm1]
Message-ID: <20060621193932.GR24595@inferi.kami.home>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44998DCB.1030703@mbligh.org> <20060621184814.GQ24595@inferi.kami.home> <44999BC5.7060702@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44999BC5.7060702@zytor.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.17-rc4-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 12:19:33PM -0700, H. Peter Anvin wrote:
> Mattia Dongili wrote:
[...]
> >.config is here: http://oioio.altervista.org/linux/config-2.6.17-mm1
> 
> I've uploaded the patch for this to:
> 
> http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-2.6.17-mm1-circdep.patch
> 
> The klibc tree has additional fixes in it.

Thanks, this is fixed, but I have a new failure:
  CC [M]  fs/xfs/support/move.o
  CC [M]  fs/xfs/support/uuid.o
  LD [M]  fs/xfs/xfs.o
  CC      fs/dnotify.o
  CC      fs/dcookies.o
  LD      fs/built-in.o
  CC [M]  fs/binfmt_aout.o
{standard input}: Assembler messages:
{standard input}:160: Error: suffix or operands invalid for `cmp'
make[1]: *** [fs/binfmt_aout.o] Error 1
make: *** [fs] Error 2

Same .config as above
-- 
mattia
:wq!
