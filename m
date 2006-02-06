Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWBFU4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWBFU4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWBFU4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:56:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60545 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964821AbWBFU4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:56:04 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 17/20] usb: Fixup usb so it works with pspaces.
References: <m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com>
	<20060206204121.GM11887@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:53:48 -0700
In-Reply-To: <20060206204121.GM11887@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Mon, 6 Feb 2006 14:41:21 -0600")
Message-ID: <m1acd4i4yr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> 
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> Just how many of these patches would have been unnecessary given your
> tref patchset?

As far as the amount of work.  It is six of one half a dozen of the
other.  This current implementation changes the logic of the code
least which I really like for maintainability.

Small bit sized chunks.

But one piece can be replaced by the other easily, the patches
are not contradictory.

Eric

