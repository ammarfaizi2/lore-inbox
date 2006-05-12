Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWELATU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWELATU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWELATU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:19:20 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:23002 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750715AbWELATT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:19:19 -0400
In-Reply-To: <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
References: <20060511143440.23517.qmail@securityfocus.com> <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <494244CE-33D6-4A9D-8C84-A439D427C143@kernel.crashing.org>
Cc: "Ed White" <ed.white@libero.it>, "ML" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: SecurityFocus Article
Date: Fri, 12 May 2006 02:19:14 +0200
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the SMRAM control register exists, the D_LCK bit can be set
> in 16-bit mode during the boot sequence. This makes the SMRAM
> register read/only so the long potential compromise sequence
> that Mr. Duflot describes would not be possible. If the control
> register doesn't exist, then the vulnerably doesn't exist.

No, if there is no mechanism to lock down SMmode (re)configuration,
the vulnerability of course _does_ exist.

> The writer doesn't like the fact that a root process can execute

Rest of this email happily ignored...


Segher

