Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVEZLqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVEZLqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 07:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVEZLqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 07:46:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51382 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261319AbVEZLqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 07:46:35 -0400
Date: Thu, 26 May 2005 13:46:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Olaf Hering <olh@suse.de>
Cc: Pavel Machek <pavel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show swsuspend only on .config where it can compile
Message-ID: <20050526114614.GG1925@elf.ucw.cz>
References: <20050526111614.GA25685@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050526111614.GA25685@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 26-05-05 13:16:14, Olaf Hering wrote:
> show swsuspend only on .config where it can compile.
> I got this on PPC32 && SMP
> 
> kernel/power/smp.c:24: error: storage size of `ctxt' isn't known
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

Thanks, applied. Also swsusp is pretty stable now, so I'll mark it as
stable.
								Pavel

