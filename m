Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUJMBKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUJMBKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUJMBKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:10:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268153AbUJMBKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:10:01 -0400
Message-ID: <416C8048.1000602@redhat.com>
Date: Tue, 12 Oct 2004 18:09:28 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041010
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com> <416C5C26.9020403@redhat.com> <20041013005856.GA3364@IBM-BWN8ZTBWA01.austin.ibm.com>
In-Reply-To: <20041013005856.GA3364@IBM-BWN8ZTBWA01.austin.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Serge E. Hallyn wrote:

>>  selinux: user_u:user_r:user_t
> 
> 
> This is exactly what my current stacker does, to the byte  :-)

This is all nice and good, but you have to bring this up with the
SELinux people _now_ since, as I said before, the current
SELinux-enabled userland code might not even start with this change of
the format even if SELinux is not enabled.  If it is decided that
/proc/*/attr/current does not belong to SELinux alone, then the guys
should be told about it now so that all the relevant code (libselinux,
kernel without your "stacker" stuff, ...) can be changed before the
current use spreads too far.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBbIBI2ijCOnn/RHQRAqXMAJ96lsdsTsZf3jI+8UXLAziK1iKC2QCfZyZT
zewSIJsYVpIFK2lG0lFcrgY=
=SGiv
-----END PGP SIGNATURE-----
