Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWITSJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWITSJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWITSJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:09:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5858 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932170AbWITSJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:09:17 -0400
Date: Wed, 20 Sep 2006 14:08:08 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060920180808.GI18646@redhat.com>
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline
In-Reply-To: <451178B0.9030205@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi -

On Wed, Sep 20, 2006 at 01:21:52PM -0400, Karim Yaghmour wrote:

> [...]  IOW, we should be able to do what Martin suggests fairly
> easily (if we agree on a 5-byte "null" jump at the entry of
> functions of interest). Right? [...]

My interpretation of Martin's Monday proposal is that, if implemented,
we wouldn't need any of this nop/int3 stuff.  If function being
instrumented were recompiled on-the-fly, then it could sport plain &
direct C-level calls to the instrumentation handlers.

- FChE

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFEYOIVZbdDOm/ZT0RAjDqAJ99GBy9KPvcQA1FmR+wWi4mglw4hwCfWsaj
fLRl4cBNUNJEiWt59qd/Ihw=
=VRqC
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--
