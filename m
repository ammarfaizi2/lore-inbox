Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTEIVcl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbTEIVcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:32:41 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:23444
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263482AbTEIVcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:32:39 -0400
Message-ID: <3EBC2164.6050605@redhat.com>
Date: Fri, 09 May 2003 14:45:08 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com>
In-Reply-To: <3EBC15B5.4070604@zytor.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

H. Peter Anvin wrote:

> No, it requires 31-bit addresses, and there was a discussion about how
> some things need 31-bit and some 32-bit addresses.

That's completely irrelevant to my point.  Whether MAP_32BIT actually
has a 31 bit limit or not doesn't matter, it's limited as well in the
possible mmap blocks it can return.

The only thing I care about is to have a hint and not a fixed
requirement for mmap().  All your proposals completely ignored this.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vCFk2ijCOnn/RHQRAnw1AKChzyuZ3g9iXAX5wH088rhko/s8YgCgku12
CayuZsLJGzPO//WCJVWyLxk=
=rkBk
-----END PGP SIGNATURE-----

