Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbTFSTp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbTFSTp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:45:29 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:8680 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S265918AbTFSTp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:45:28 -0400
Message-ID: <3EF215B0.1090401@redhat.com>
Date: Thu, 19 Jun 2003 12:57:36 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030614
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: potential set_child_tid/clear_child_tid bug
References: <200306191937.h5JJbMff032515@napali.hpl.hp.com>
In-Reply-To: <200306191937.h5JJbMff032515@napali.hpl.hp.com>
X-Enigmail-Version: 0.76.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Mosberger wrote:
> At the moment, if you don't set CLONE_CHILD_SETTID/CLONE_CHILD_CLEARTID,
> the {set,clear}_child_tid values get inherited from the parent task.
> I may be missing something, but I suspect that's not the intended behavior.

Your change certainly creates the behavior I'd expect.  I always thought
it is already the case.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+8hWw2ijCOnn/RHQRAsP7AJ4gDQx1iTrvBXn7z4QV2ZtyQCQ67ACgqQ6v
VtwMo6ATImKddiwrNER0+sI=
=542N
-----END PGP SIGNATURE-----

