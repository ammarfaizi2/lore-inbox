Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbRGKXhI>; Wed, 11 Jul 2001 19:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266915AbRGKXg5>; Wed, 11 Jul 2001 19:36:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16145 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266888AbRGKXgz>; Wed, 11 Jul 2001 19:36:55 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Switching Kernels without Rebooting?
Date: 11 Jul 2001 16:36:52 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9iinuk$tis$1@cesium.transmeta.com>
In-Reply-To: <3B4C180E.D3AE1960@idb.hist.no> <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org>
By author:    Paul Jakma <paul@clubi.ie>
In newsgroup: linux.dev.kernel
>
> On Wed, 11 Jul 2001, Helge Hafting wrote:
> 
> > That seems completely out of question.  The structures a 2.4.7
> > kernel understands might be insufficient to express the setup
> > a future 2.6.9 kernel is using to do its stuff better.
> 
> however, it might be handy if say you needed to upgrade a stable
> kernel due to a bug fix or security update.
> 
> no?
> 

No.  You have no guarantee that the state or state mangler won't
propagate the bug into the new kernel, even if it has been fixed.
Since many, if not most, bug fixes or security upgrades are related to
state getting mucked up, this is a very serious thing.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
