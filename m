Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRFWW3z>; Sat, 23 Jun 2001 18:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRFWW3q>; Sat, 23 Jun 2001 18:29:46 -0400
Received: from [205.201.12.35] ([205.201.12.35]:52055 "EHLO odin.buserror.net")
	by vger.kernel.org with ESMTP id <S261969AbRFWW3d>;
	Sat, 23 Jun 2001 18:29:33 -0400
Date: Sat, 23 Jun 2001 18:29:28 -0400
To: Rick Hohensee <humbubba@smarty.smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
Message-ID: <20010623182928.A8186@odin>
In-Reply-To: <200106220305.XAA15554@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106220305.XAA15554@smarty.smart.net>; from humbubba@smarty.smart.net on Thu, Jun 21, 2001 at 11:05:13PM -0400
From: Scott Wood <scott@buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 11:05:13PM -0400, Rick Hohensee wrote:
> Richard Stallman is the creator of the license. It's his greatest work.
> Linus is in no way priviledged as to interpretation of it, other than
> tolerance on the part of the parties that own the copyright to the
> license.

Neither is RMS, though; the license is the text of the GPL, not anything RMS
may have said about it since.

> The GPL is about "the program". As far as I'm concerned, modules are the
> kernel, "the program".

The modules are *not* "the kernel".  They are independent (except for header
files, but you didn't make that argument, and it's by no means certain to
hold up in court, especially if you don't use any code from the headers)
pieces of code that happen to interact with the kernel.  Why are modules,
from a legal standpoint, different from user programs?  And since when are
derivative works under copyright law determined by the opinion of the
copyright holder (much less any random third party that doesn't happen to be
a court), other than to be more lenient than the law requires?

> The way to stem any panic that may exist, if you want to allow binary-only
> modules (which sucks*, but whatever)

Sure, they suck, but only for the users that choose to use them and the
providers of the modules that have to deal with the maintenance issues. 
What sucks even more, though, is someone else making the choice for them.

> *How 'bout a nice binary-only Forth running the kernel? Metacompiling
> kernel routines into the Forth dictionary and such. Sound creepy? Good.

The only creepy thing here is the kernel being written in Forth; if you
don't want to run it in that binary-only implementation, find (or write) a
free one that will get the job done.  There's no need to get the courts and
lawyers involved, and no need to punish the users of the software by
restricting what they can do.

-Scott
