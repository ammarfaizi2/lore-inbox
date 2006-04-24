Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWDXNJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWDXNJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDXNJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:09:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:5357 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750770AbWDXNJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:09:51 -0400
Date: Mon, 24 Apr 2006 08:09:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Olivier Galibert <galibert@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424130949.GE9311@sergelap.austin.ibm.com>
References: <4446D378.8050406@novell.com> <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu> <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain> <20060424124556.GA92027@dspnet.fr.eu.org> <1145883251.3116.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145883251.3116.27.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven (arjan@infradead.org):
> for all such things in the first place. In fact, we already know that to
> do auditing, LSM is the wrong thing to do (and that's why audit doesn't
> use LSM). It's one of those fundamental linux truths: Trying to be

As I recall it was simply decided that LSM must be "access control
only", and that was why it wasn't used for audit.

Didn't Linda Walsh claim a much faster audit implementation using LSM
than the current lightweight audit framework?

-serge
