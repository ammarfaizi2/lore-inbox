Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUC1UjE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUC1Uim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:38:42 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:38092 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S262416AbUC1UgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:36:20 -0500
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
References: <yw1xsmftnons.fsf@ford.guide>
	<20040328201719.A14868@jurassic.park.msu.ru>
	<yw1xoeqhndvl.fsf@ford.guide>
	<20040328204308.C14868@jurassic.park.msu.ru>
	<20040328221806.7fa20502@vaio.gigerstyle.ch>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 28 Mar 2004 22:36:17 +0200
In-Reply-To: <20040328221806.7fa20502@vaio.gigerstyle.ch> (Marc Giger's
 message of "Sun, 28 Mar 2004 22:18:06 +0200")
Message-ID: <yw1xr7vcn1z2.fsf@ford.guide>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Marc Giger <gigerstyle@gmx.ch> writes:

> Hi Ivan, Hi M=E5ns
>
> I haven't found the time to look deeper into the problem. All what I can
> say ATM is, it is real and exists!
>
> Ivan, perhaps you can give me some useful advise how to debug this
> successfully? I think we should begin to try isolating the problem to a
> single part of the kernel.=20
> Is it possible that we have a deadlock in the VFS part? After a
> while every process that accesses a file will be blocked (already
> described).

We could start by comparing .config files.  Mine is attached.  I've
been running a 2.6.3 kernel with that configuration since it was
released.  I compiled a gentoo installation using that kernel, so I'd
say it's quite stable.

--=20
M=E5ns Rullg=E5rd
mru@kth.se


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=config.gz
Content-Transfer-Encoding: base64

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
7GkaNUEAAA==
--=-=-=--
