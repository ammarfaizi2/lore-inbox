Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTHVAub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbTHVAub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:50:31 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:7809 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S262960AbTHVAu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:50:29 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Miles Bader <miles@gnu.org>, Miles Bader <miles@lsi.nec.co.jp>
Subject: Re: Initramfs confusion
Date: Thu, 21 Aug 2003 20:49:27 -0400
User-Agent: KMail/1.5
Cc: gkajmowi@tbaytel.net, linux-kernel@vger.kernel.org
References: <200308161940.52579.gkajmowi@tbaytel.net> <200308190414.10317.rob@landley.net> <buor83f710t.fsf@mcspd15.ucom.lsi.nec.co.jp>
In-Reply-To: <buor83f710t.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308212049.27693.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 August 2003 06:33, Miles Bader wrote:
> Rob Landley <rob@landley.net> writes:
> > Here's a big cut and paste from a script of mine that does a lot of
> > this gorp automatically while creating a bootable CD image.
>
> I've no idea what the original poster really wants, but your script
> seems to use initrd, not initramfs (which is much nicer than initrd in
> theory).

The script was done for 2.4, where initramfs wasn't an option.  (I mentioned 
it being old, and a bit crufty.)

The original poster was saying they were having trouble creating a 2.88 floppy 
image, which is most of what that script snippet does.  (The bit that 
actually creates the root ramdisk that floppy uses was earlier in the script, 
and not included in the snip.  I believe the script just had a line to copy 
the ramdisk file onto the floppy image...)

> -Miles

Rob
