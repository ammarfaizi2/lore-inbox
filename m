Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbRHGRHF>; Tue, 7 Aug 2001 13:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269202AbRHGRGz>; Tue, 7 Aug 2001 13:06:55 -0400
Received: from bender.toppoint.de ([195.244.243.2]:34689 "EHLO
	mail.toppoint.de") by vger.kernel.org with ESMTP id <S269186AbRHGRGq>;
	Tue, 7 Aug 2001 13:06:46 -0400
>Received: (from netzwurm@localhost)
	by gandalf.discordia (8.9.3/8.9.3/Debian 8.9.3-21) id SAA28644;
	Tue, 7 Aug 2001 18:21:04 +0200
Date: Tue, 7 Aug 2001 18:21:04 +0200
From: David Spreen <david@spreen.de>
To: David Maynor <david.maynor@oit.gatech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap
Message-ID: <20010807182104.A28490@foobar.toppoint.de>
In-Reply-To: <5.1.0.14.2.20010807110412.00a8bec0@pop.prism.gatech.edu>
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20010807110412.00a8bec0@pop.prism.gatech.edu>; from david.maynor@oit.gatech.edu on Tue, Aug 07, 2001 at 11:06:36AM -0400
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 11:06:36AM -0400, David Maynor wrote:
> But is the 10% perf hit really gaining you anything, expect to quell your 
> paranoia. What is next, an encrypted /proc so that possible attackers can't 
> gain information about running processes?

This was not the point. I you don't care about your data on disks which
maybe stolen (for example in notebooks) this is okay for me. 
My question was only if there's an existing implementation of this.
10 - 30% performance problems are quite acceptable for 
good privacy aren't they?

So if I understood you guys correctly it would be possible by
getting random-data at boottime and use them to build a key
(for example with the algorythms from the kerneli patch), which
will be used to encrypt the swapped out data right?

Would be cool to hear from some others who are interested in 
such an implementation of crypted swap, maybe we could start
something like that.

Btw. one of the BSDs uses encrypted swap too iirc, how did they
implement?

so long...

David
-- 
  __          _              | David "netzwurm" Spreen      Kiel, Germany
 / _|___  ___| |__  __ _ _ _ | http://www.netzwurm.cc/      david@spreen.de
|  _/ _ \/ _ \ '_ \/ _` | '_|| gnupg key (on keyservers):   C8B6823A
|_| \___/\___/_.__/\__,_|_|  | CellPhone:                   +49 173 3874061

