Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVFWOOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVFWOOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 10:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVFWOOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 10:14:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58891 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262537AbVFWOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 10:14:28 -0400
Date: Thu, 23 Jun 2005 15:14:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [patch 1/4] delete include/asm-arm/arch-epxa10db/mode_ctrl00.h
Message-ID: <20050623151422.B5564@flint.arm.linux.org.uk>
Mail-Followup-To: domen@coderock.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk
References: <20050620214923.882427000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050620214923.882427000@nd47.coderock.org>; from domen@coderock.org on Mon, Jun 20, 2005 at 11:49:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 11:49:24PM +0200, domen@coderock.org wrote:
> Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Don't know what to do about epxa10db.  I never merged the corresponding
drivers/pld subdirectory, which I suspect uses this stuff.  No one
complained about that either.

If this file goes, I'll have to remove drivers/pld from my tree, in
which case that code gets irretrievably lost.  Alternatively I could
submit it, but I've no idea what state it's in now.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
