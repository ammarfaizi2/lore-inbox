Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRB0Vf6>; Tue, 27 Feb 2001 16:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRB0Vfs>; Tue, 27 Feb 2001 16:35:48 -0500
Received: from 13dyn203.delft.casema.net ([212.64.76.203]:2576 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129583AbRB0Vfj>; Tue, 27 Feb 2001 16:35:39 -0500
Message-Id: <200102272135.WAA23965@cave.bitwizard.nl>
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010227143823.A25058@cistron.nl> from Ivo Timmermans at "Feb 27,
 2001 02:38:23 pm"
To: Ivo Timmermans <irt@cistron.nl>
Date: Tue, 27 Feb 2001 22:35:35 +0100 (MET)
CC: "Heusden, Folkert van" <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivo Timmermans wrote:
> Heusden, Folkert van wrote:
> > > When running a script (perl in this case) that has DOS-style newlines
> > > (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> > > recognize the \r.  The following patch should fix this (untested).
> > 
> > _should_ it work with the \r in it?
> 
> IMHO, yes.  This set of files were created on Windows, then zipped and
> uploaded to a Linux server, unpacked.  This does not change the \r.

Use the right option on "unzip" to unpack with cr/lf conversion.

Otherwise, use a script that does it afterwards. 

			Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
