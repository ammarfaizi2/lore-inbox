Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132853AbRDUTiS>; Sat, 21 Apr 2001 15:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132854AbRDUTiI>; Sat, 21 Apr 2001 15:38:08 -0400
Received: from ns.suse.de ([213.95.15.193]:31236 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132853AbRDUTiD>;
	Sat, 21 Apr 2001 15:38:03 -0400
Date: Sat, 21 Apr 2001 21:37:51 +0200
From: Andi Kleen <ak@suse.de>
To: Peter Makholm <peter@makholm.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Idea: Encryption plugin architecture for file-systems
Message-ID: <20010421213751.A13395@gruyere.muc.suse.de>
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com> <8766fyt5x3.fsf@xyzzy.adsl.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8766fyt5x3.fsf@xyzzy.adsl.dk>; from peter@makholm.net on Sat, Apr 21, 2001 at 09:21:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 09:21:44PM +0200, Peter Makholm wrote:
> nagytam@rerecognition.com ("Tamas Nagy") writes:
> 
> > Idea:
> > extend the current file-system with an optional plug-in system, which allows
> > for file-system level encryption instead of file-level.
> 
> That's is one of the things the loop device offers. For better
> encryption than XOR you need the patches from kerneli.org.

No, you don't. The standard kernel loop device supports loading of external 
crypto filters just fine; no patching at all required.


-Andi
