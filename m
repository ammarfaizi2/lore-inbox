Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277728AbRJROsY>; Thu, 18 Oct 2001 10:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277729AbRJROsO>; Thu, 18 Oct 2001 10:48:14 -0400
Received: from zork.zork.net ([64.81.65.8]:19723 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S277728AbRJROr6>;
	Thu, 18 Oct 2001 10:47:58 -0400
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
From: Sean Neakums <sneakums@zork.net>
X-Message-Flag: Message text advisory: HATE SPEECH, ARGUMENTUM AD BACULUM
X-Mailer: Norman
Date: Thu, 18 Oct 2001 15:48:29 +0100
Message-ID: <6ulmi9vwaq.fsf@zork.zork.net>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin  Horst von Brand quotation:
> =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr> said:
> 
> > Be very careful not to modify a multi-linked file, or
> > it will be damaged in all trees and won't be seen by
> > diff. your editor must unlink before saving.
> 
> Most don't. ed(1), vi(1) and emacs(1) are careful tro write to the
> very same file. jed(1) is the only outlier I'm aware of...

If Emacs is configured to save backups (it is shipped with this option
on by default) the existing file is renamed to the backup name and the
new, changed file is saved in a fresh file.  Thus the trick of diffing
two co-linked trees of files should work as expected.

Emacs users should look in the info node "(emacs)Backup Copying" for
complete information on this.

-- 
 /////////////////  |                  | The spark of a pin
<sneakums@zork.net> |  (require 'gnu)  | dropping, falling feather-like.
 \\\\\\\\\\\\\\\\\  |                  | There is too much noise.
