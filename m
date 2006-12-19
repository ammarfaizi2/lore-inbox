Return-Path: <linux-kernel-owner+w=401wt.eu-S932657AbWLSIe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWLSIe6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWLSIe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:34:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:60062 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbWLSIe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:34:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=jCG3vQKrMiG61iq9fowEX4q6a7So0L1j/Zau0n4/6xemE2UXLo6921lx4gt3U5AL//1giebLZkBdqtj+CWnl5lJSz638XtUrGuUavG7o+4/MuT/0p5yoz/IN1MsTx/EGWS/jko9X3LdYo+pD4s1X2bP4mW/nn/+AhtswHUTzJfo=
Message-ID: <84144f020612190034s3936a1b6k9ab50a283d63135@mail.gmail.com>
Date: Tue, 19 Dec 2006 10:34:55 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19 file content corruption on ext3
Cc: andrei.popa@i-neo.ro, "Linus Torvalds" <torvalds@osdl.org>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Hugh Dickins" <hugh@veritas.com>, "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Michlmayr" <tbm@cyrius.com>
In-Reply-To: <20061219002416.ed8f1dda.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1166314399.7018.6.camel@localhost>
	 <1166485691.6977.6.camel@localhost>
	 <Pine.LNX.4.64.0612181559230.3479@woody.osdl.org>
	 <1166488199.6950.2.camel@localhost>
	 <Pine.LNX.4.64.0612181648490.3479@woody.osdl.org>
	 <20061218172126.0822b5d2.akpm@osdl.org>
	 <1166492691.6890.12.camel@localhost>
	 <20061218175449.3c752879.akpm@osdl.org>
	 <1166515504.6897.0.camel@localhost>
	 <20061219002416.ed8f1dda.akpm@osdl.org>
X-Google-Sender-Auth: d0b0a9f7b1e23711
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Andrew Morton <akpm@osdl.org> wrote:
> Wow.  I didn't expect that, because Mark Haber reported that ext3's data=writeback
> fixed it.   Maybe he didn't run it for long enough?

I don't think it did fix it for Mark:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116625777306843&w=2
