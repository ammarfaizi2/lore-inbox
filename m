Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbTAQKmb>; Fri, 17 Jan 2003 05:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTAQKmb>; Fri, 17 Jan 2003 05:42:31 -0500
Received: from users.linvision.com ([62.58.92.114]:47525 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S267482AbTAQKma>; Fri, 17 Jan 2003 05:42:30 -0500
Date: Fri, 17 Jan 2003 11:51:03 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: DervishD <raul@pleyades.net>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: argv0 revisited...
Message-ID: <20030117115103.A5284@bitwizard.nl>
References: <20030115184455.GB47@DervishD> <200301161104.h0GB4IOY011937@eeyore.valparaiso.cl> <20030116112745.GE87@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030116112745.GE87@DervishD>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 12:27:45PM +0100, DervishD wrote:
>     That is, for clarity, those should be 'renamed'. I cannot rename
> the binary, because all them are in the same binary. The only way is
> mangling argv[0] in each fork, that's all. Currently, as I know for

ln init klogd
ln init slog
ln init into

main (...)
{
   if (strstr (argv[0], "klogd")) 
	go_do_klogd ();
...

This is similar to what busybox uses. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
