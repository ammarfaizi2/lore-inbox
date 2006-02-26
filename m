Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWBZNYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWBZNYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWBZNYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:24:19 -0500
Received: from CPE-24-31-249-53.kc.res.rr.com ([24.31.249.53]:36772 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751116AbWBZNYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:24:18 -0500
From: Luke-Jr <luke@dashjr.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works ;)
Date: Sun, 26 Feb 2006 13:30:15 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200602250042.51677.bero@arklinux.org>
In-Reply-To: <200602250042.51677.bero@arklinux.org>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602261330.15709.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 23:42, Bernhard Rosenkraenzer wrote:
> I've just released dvdrtools 0.3.1
> (http://www.arklinux.org/projects/dvdrtools/). It is a fork of cdrtools
> that (as the name indicates) adds support for writing to DVD-R and DVD-RW
> disks using purely Free Software,

also DVD+R/RW/DL, I hope?

> that tries to do things the Linux way ("dvdrecord dev=/dev/cdrom
> whatever.iso")

Shouldn't that be "dvdrecord whatever.iso /dev/cdrom" or similar?
Any plans to support growing an ISO fs (ala growisofs)? Maybe by simply 
including a modified growisofs using dvdrecord-libscg?
