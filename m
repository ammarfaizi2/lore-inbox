Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSIAJKP>; Sun, 1 Sep 2002 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSIAJKO>; Sun, 1 Sep 2002 05:10:14 -0400
Received: from users.linvision.com ([62.58.92.114]:1433 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S316594AbSIAJKO>; Sun, 1 Sep 2002 05:10:14 -0400
Date: Sun, 1 Sep 2002 11:14:33 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, R.E.Wolff@BitWizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/atm/firestream.c doesn't compile in 2.5.33
Message-ID: <20020901111433.A23165@bitwizard.nl>
References: <Pine.NEB.4.44.0209010227250.147-100000@mimas.fachschaften.tu-muenchen.de> <3D716D23.1000101@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D716D23.1000101@oracle.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 03:28:03AM +0200, Alessandro Suardi wrote:
> Same symptom as the cpia.c (and IrDA, too). Just change
> 
> #define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter " 
> __FUNCTION__ "\n")
> 
> to
> 
> #define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter %s\n", 
> __FUNCTION__)

Ehmm. 

I wrote that code, and I made a decision to do it that way. Did
I use "invalid C" or did the C spec change? 

Or did the __FUNCTION__ extension from gcc change? Someone please
explain.....

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
