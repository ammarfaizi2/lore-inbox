Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbRFLPXp>; Tue, 12 Jun 2001 11:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261881AbRFLPXf>; Tue, 12 Jun 2001 11:23:35 -0400
Received: from stanis.onastick.net ([207.96.1.49]:56081 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S261840AbRFLPXY>; Tue, 12 Jun 2001 11:23:24 -0400
Date: Tue, 12 Jun 2001 11:23:02 -0400
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
Message-ID: <20010612112302.A16949@sigkill.net>
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk> <20010612154735.B17905@flint.arm.linux.org.uk> <15142.11907.782662.581523@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <15142.11907.782662.581523@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, David S. Miller did have cause to say:

> Look everyone, it was determined to be a deadlock because of some
> interaction between how rsync sets up it's communication channels
> with the ssh subprocess, readas: userland bug.

....we're not using ssh. :(

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
