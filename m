Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266453AbUGJWPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUGJWPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 18:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbUGJWPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 18:15:32 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:42314 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S266453AbUGJWPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 18:15:30 -0400
Date: Sat, 10 Jul 2004 17:15:29 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bk pull from bkbits screwy?
Message-ID: <20040710221529.GA12455@hexapodia.org>
References: <20040710065802.GA29604@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710065802.GA29604@net-ronin.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 11:58:02PM -0700, carbonated beverage wrote:
> I sent a patch a while ago to change the bk:// to http:// in the docs,
> but was told bk:// was working again.  Just did a bk pull again right now,
> and bk:// doesn't seem to be working, whereas reparenting my repo to http://
> and doing a bk pull works.  Am I missing something?

How about giving the command that didn't work, and the error messages it
printed?  I just did a pull using bk://linux.bkbits.net/linux-2.5 and it
succeeded:

...
takepatch: 25577 new revisions, 0 conflicts in 6840 files
8439936 bytes uncompressed to 36145013, 4.28X expansion
Running resolve to apply new work ...
Using :0.0 as graphical display
resolve: found 491 renames in pass 1
resolve: resolved 491 renames in pass 2
resolve: applied 6840 files in pass 4
resolve: running consistency check, please wait...
100% |=================================================================| OK
Consistency check passed, resolve complete.
straum% bk pull
Pull bk://linux.bkbits.net/linux-2.5
  -> file://data/linux/linux-2.5
Nothing to pull.
straum%

There are two different URL syntaxes that start "bk://" and perhaps
you're using the wrong one.  (I got caught by that one a while back.)

And yes, bk:// is preferred over http://, in general.

-andy
