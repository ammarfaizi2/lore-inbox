Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSIXFkI>; Tue, 24 Sep 2002 01:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSIXFkI>; Tue, 24 Sep 2002 01:40:08 -0400
Received: from einstein.kowalk.Informatik.Uni-Oldenburg.de ([134.106.55.1]:59271
	"EHLO walker.pmhahn.de") by vger.kernel.org with ESMTP
	id <S261573AbSIXFkH>; Tue, 24 Sep 2002 01:40:07 -0400
Date: Mon, 23 Sep 2002 17:28:27 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jean Tourrilhes <jt@hpl.hp.com>
Subject: Re: Linux 2.5.38 [PATCH] IrDA
Message-ID: <20020923152827.GB22333@titan.lahn.de>
Mail-Followup-To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jean Tourrilhes <jt@hpl.hp.com>
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin LKML, Jean!

On Sat, Sep 21, 2002 at 09:34:18PM -0700, Linus Torvalds wrote:
> Jean Tourrilhes <jt@hpl.hp.com>:
>   o More __FUNCTION__ cleanups for IrDA

More to find at http://pint.pmhahn.de/pmhahn/misc/irda-2.5.38.diff
since it is too large (228099 Bytes) for LKML.

BYtE
Philipp

PS: The magic "vim" like was
%s!__FUNCTION__\s*\(\n\s*\)\?"\([^"]*"\(\s*\n\s*"[^"]*"\)\?\)\(\s*[,)]\)!\1"%s\2, __FUNCTION__ \4!
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
