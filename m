Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTEGSvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbTEGSvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:51:12 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:27270
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264181AbTEGSvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:51:11 -0400
Message-ID: <3EB95887.7000909@redhat.com>
Date: Wed, 07 May 2003 12:03:35 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Eric Piel <Eric.Piel@Bull.Net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: DELAYTIMER_MAX is defined
References: <3EB7E3DA.C50258A9@Bull.Net> <3EB81719.3050705@mvista.com> <3EB8B5EA.BD5D1C19@Bull.Net> <3EB8BA67.4060708@redhat.com> <3EB8F54C.CC5488F0@Bull.Net> <3EB92023.2000906@mvista.com> <3EB94E8F.2080001@redhat.com> <3EB954DF.7060701@mvista.com>
In-Reply-To: <3EB954DF.7060701@mvista.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

george anzinger wrote:
> Andrew Morton suggested
> an rlimit for that.  Perhaps that is what should be used here also.
> 
> Seem reasonable?

For this as well?  We are getting an awful lot of these it seems.

The DELAYTIMER_MAX thing probably can be hardcoded.  I can see no harm
in limiting it to 1000 or so.  The number of timers can be handled via
rlimit.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uViH2ijCOnn/RHQRApl3AKC6l4zZMsn7SaiGSw6hb9KZpc5cQACgm1NW
09sC2WWGZsw1QAUxcTjo8rI=
=Nafv
-----END PGP SIGNATURE-----

