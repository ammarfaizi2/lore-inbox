Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271128AbUJUXWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271128AbUJUXWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbUJUXWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:22:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58568 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S271104AbUJUXLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:11:00 -0400
Message-ID: <417841ED.6040903@redhat.com>
Date: Thu, 21 Oct 2004 16:10:37 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: NPTL: Parent thread receives SIGHUP when child thread terminates?
References: <20041021101313.GA19246@vana.vc.cvut.cz>
In-Reply-To: <20041021101313.GA19246@vana.vc.cvut.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Vandrovec wrote:

>   When process is session leader, is it supposed to receive SIGHUP when child
> thread terminates?

No, it's not.  I hope somebody knowing the signal code will look at
this.  I've forwarded the mail to Roland.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBeEHt2ijCOnn/RHQRAsSmAJ9RXjR71D/rLDEG2IxKt5++VYfRGACdELgM
uxry9CwYy5/j/a2dHGyKdX0=
=V+53
-----END PGP SIGNATURE-----
