Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbSBGHKH>; Thu, 7 Feb 2002 02:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbSBGHJ5>; Thu, 7 Feb 2002 02:09:57 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:38889 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S285093AbSBGHJr>; Thu, 7 Feb 2002 02:09:47 -0500
Message-Id: <200202061326.g16DQN3E001296@tigger.cs.uni-dortmund.de>
To: Marco Colombo <marco@esi.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: Message from Marco Colombo <marco@esi.it> 
   of "Wed, 06 Feb 2002 12:29:54 +0100." <Pine.LNX.4.44.0202061158180.1381-100000@Megathlon.ESI> 
Date: Wed, 06 Feb 2002 14:26:23 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Colombo <marco@esi.it> said:

[...]

> No, applications already can (should) recover from a "missing feature"
> error, after executing some syscall. Even if your .config says you've
> compile the scsi tape driver into the running kernel, it doesn't mean
> there is a scsi tape attached somewhere. And if your kernel is modular,
> how can an application tell if some module is avalable? .config may
> say that feature was compliled as a module, but has no knowledge of the
> binary module being accessible or not.

.config might even say there is no support for <foo>, but there is in the
form of a third-party module addon. The only way out is to try and recover
if it fails.
-- 
Horst von Brand			     http://counter.li.org # 22616
