Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132739AbRC2PHw>; Thu, 29 Mar 2001 10:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132749AbRC2PHm>; Thu, 29 Mar 2001 10:07:42 -0500
Received: from lech.pse.pl ([194.92.3.7]:52621 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S132739AbRC2PH3>;
	Thu, 29 Mar 2001 10:07:29 -0500
Date: Thu, 29 Mar 2001 17:06:28 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: clock@ghost.btnet.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: diskette change problems
Message-ID: <20010329170628.B28407@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: clock@ghost.btnet.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20010329123831.A156@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010329123831.A156@ghost.btnet.cz>; from clock@ghost.btnet.cz on Thu, Mar 29, 2001 at 12:38:31PM +0200
Organization: Polskie Sieci Elektroenergetyczne S.A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I put a write-protected diskette into fd0
> cat /dev/zero > /dev/fd0: readonly filesystem
> then removed dikette, switched the plastic nibble
> reinserted diskette
> cat /dev/zero > /dev/fd0 : readonly filesystem

Are you sure your FDD correctly recognizes media changes? Is there
anything like "kernel: VFS: Disk change detected on device fd(2,0)"
noted in your logfiles?

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
