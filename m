Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbTEGSIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTEGSIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:08:45 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:56965
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264157AbTEGSIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:08:43 -0400
Message-ID: <3EB94E8F.2080001@redhat.com>
Date: Wed, 07 May 2003 11:21:03 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Eric Piel <Eric.Piel@Bull.Net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: DELAYTIMER_MAX is defined
References: <3EB7E3DA.C50258A9@Bull.Net> <3EB81719.3050705@mvista.com> <3EB8B5EA.BD5D1C19@Bull.Net> <3EB8BA67.4060708@redhat.com> <3EB8F54C.CC5488F0@Bull.Net> <3EB92023.2000906@mvista.com>
In-Reply-To: <3EB92023.2000906@mvista.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

george anzinger wrote:

> This, of course, also says that we should not only limit the value of
> overrun, but also do something different when it happens.

That's legitimate and in this case we perhaps should publish this lower
value since it can be limiting.  Since real work is involved in having
higher values this constiutes another possible DoS in the code and has
to be resolved.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uU6P2ijCOnn/RHQRAralAJ43h7EBj8sqm2QmmdTGXwBiAL9LUQCgignS
Lu4ITL+4lDmZXoK0BR8UFLU=
=DKUl
-----END PGP SIGNATURE-----

