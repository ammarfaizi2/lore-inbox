Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292482AbSCOOLb>; Fri, 15 Mar 2002 09:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292515AbSCOOLW>; Fri, 15 Mar 2002 09:11:22 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:33518 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292482AbSCOOLP>; Fri, 15 Mar 2002 09:11:15 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020315131612.C24984@flint.arm.linux.org.uk> 
In-Reply-To: <20020315131612.C24984@flint.arm.linux.org.uk> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Mar 2002 14:11:04 +0000
Message-ID: <30439.1016201464@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  The following patch removes Alt-Sysrq-L and its associated hack to
> kill of PID1, the init process.  This is a mis-feature.

This is not a mis-feature.

> If PID1 is killed, the kernel immediately enters an infinite loop in
> the depths of do_exit() with interrupts disabled, completely locking
> the machine.  Obviously you can only reach for the reset button or
> power switch after this, leaving you with dirty filesystems.

This is a mis-feature. Leaving you without even the facility to use SysRq 
any further is just insane.

--
dwmw2


