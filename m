Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRKYOjo>; Sun, 25 Nov 2001 09:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277024AbRKYOjd>; Sun, 25 Nov 2001 09:39:33 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:23944 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S276344AbRKYOjN>; Sun, 25 Nov 2001 09:39:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
	<20011125143449.B5506@duron.intern.kubla.de>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 25 Nov 2001 15:39:08 +0100
In-Reply-To: <20011125143449.B5506@duron.intern.kubla.de> (Dominik Kubla's message of "Sun, 25 Nov 2001 14:34:49 +0100")
Message-ID: <tgadxagbjn.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla <kubla@sciobyte.de> writes:

> On Sat, Nov 24, 2001 at 04:39:15PM -0200, Marcelo Tosatti wrote:
> 
> > - Correctly sync inodes in iput()			(Alexander Viro)
> 
> Given the  fact that  this bug  in a presumably  stable linux  kernel is
> getting quite some attention in the media (electronic and otherwise). It
> would be prudent  to get out a  2.4.16 which fixes this  bug right about
> now.

BTW, what is the correct recovery strategy, assuming 2.4.15 has not
been rebooted yet?  Installing a fixed kernel is obviously the first
step.  How should one reboot the system to minimize damage?  Use a
normal system shutdown (with the -F parameter to forc fsck on next
boot), or go to single user, "touch /forcefsck", sync, wait a minute,
and switching of power?

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
