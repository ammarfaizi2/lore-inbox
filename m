Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbTBFSML>; Thu, 6 Feb 2003 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTBFSML>; Thu, 6 Feb 2003 13:12:11 -0500
Received: from linux3.contactor.se ([193.15.23.23]:37339 "EHLO
	linux3.contactor.se") by vger.kernel.org with ESMTP
	id <S267487AbTBFSMK>; Thu, 6 Feb 2003 13:12:10 -0500
Date: Thu, 6 Feb 2003 19:21:31 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Stenberg <bjorn@haxx.se>
To: Olaf Hering <olh@suse.de>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21pre: ide_fix_driveid unresolved in usb-storage
Message-ID: <20030206182131.GB15140@linux3.contactor.se>
References: <20030206175221.GA3072@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030206175221.GA3072@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> drivers/usb/storage/isd200.c calls ide_fix_driveid()
> This function is only available when CONFIG_IDE is active.

I know. I submitted a patch for this in September 2002:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103305998718432&w=2

...which was rejected "until people make up their minds" about how ide_fix_driveid() should be implemented in various architectures:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103310439026491&w=2

I've been meaning to remind Matt and Greg about this issue.

-- 
Björn (not subscribed to lkml)
