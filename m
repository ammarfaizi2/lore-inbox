Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271486AbRIVPXt>; Sat, 22 Sep 2001 11:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRIVPXj>; Sat, 22 Sep 2001 11:23:39 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:37646 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S271486AbRIVPX0>; Sat, 22 Sep 2001 11:23:26 -0400
Date: Sat, 22 Sep 2001 11:23:51 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Whats in the wings for 2.5 (when it opens)
Message-ID: <20010922112351.D9352@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010922103100.C9352@mueller.datastacks.com> <28866.1001169893@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <28866.1001169893@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Sep 23, 2001 at 12:44:53AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 23/09/01 00:44 +1000 - Keith Owens:
> On Sat, 22 Sep 2001 10:31:00 -0400, 
> Crutcher Dunnavant <crutcher@datastacks.com> wrote:
> >++ 22/09/01 12:59 +1000 - Keith Owens:
> >> Post kbuild 2.5 I will be writing a generic parameter/command line
> >> interface so you can insmod foo bar=99 or boot with foo.bar=99.  You
> >> will even be able to boot with foo.bar=99 when foo is a module, insmod
> >> will use the command line as a default set of values.
> >
> >Well, that certainly is clean. How deep does it go?
> 
> One level, flat.  Module names must be unique, -DKBUILD_OBJECT runs off
> module names.

Yes, but can module names contain periods? If they can, then there can
be a notional heirarchy, and that's really all that's needed.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
