Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285130AbRL1BAl>; Thu, 27 Dec 2001 20:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283938AbRL1BAa>; Thu, 27 Dec 2001 20:00:30 -0500
Received: from t2.redhat.com ([199.183.24.243]:2296 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285130AbRL1BAP>; Thu, 27 Dec 2001 20:00:15 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011224122605.A2110@flint.arm.linux.org.uk> 
In-Reply-To: <20011224122605.A2110@flint.arm.linux.org.uk>  <20011223175846.B27993@flint.arm.linux.org.uk> <E16IKwX-0002U3-00@the-village.bc.nu> <20011224083752.A1181@flint.arm.linux.org.uk> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Total system lockup with Alt-SysRQ-L 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 01:00:04 +0000
Message-ID: <8733.1009501204@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  Ok, can someone explain *why* it is desirable to attempt to kill pid1
> given that doing so will completely lockup the machine?  (should we
> rename it to "Lockup" instead of "killalL"? 8) 

It's not. I believe SysRq-L was implemented while Linux would still exhibit 
sane behaviour upon pid1 dying, and was never removed when the current 
brokenness was introduced.

--
dwmw2


