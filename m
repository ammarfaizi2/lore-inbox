Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTEITMe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTEITMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:12:34 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:37267
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263397AbTEITMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:12:33 -0400
Message-ID: <3EBC0084.4090809@redhat.com>
Date: Fri, 09 May 2003 12:24:52 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com>
In-Reply-To: <b9gr03$42n$1@cesium.transmeta.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

H. Peter Anvin wrote:

> How about this: since the address argument is basically unused anyway
> unless MAP_FIXED is set, how about a MAP_MAXADDR which interprets the
> address argument as the highest permissible address (or lowest
> nonpermissible address)?

You miss the point of my initial mail: I need a way to say "preferrably
32bit address, otherwise give me what you have".  MAP_32BIT already
provides a way to require 32 bit addresses.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vACE2ijCOnn/RHQRAl3rAKCYgj3LqvIDJ8Ny3pnii8bBvsbwrQCdGkg4
pnFnBmubkRnnsVfBSjDBBWQ=
=P8SV
-----END PGP SIGNATURE-----

