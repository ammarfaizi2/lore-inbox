Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWCGNKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWCGNKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWCGNKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:10:36 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:17132 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750730AbWCGNKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:10:36 -0500
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: initcall at ... returned with error code -19 (Was: Re: 2.6.16-rc5-mm2)
References: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com>
	<20060306140851.4140ae2b.akpm@osdl.org>
	<20060306170919.0fcd8566.pj@sgi.com>
From: Jes Sorensen <jes@sgi.com>
Date: 07 Mar 2006 08:10:33 -0500
In-Reply-To: <20060306170919.0fcd8566.pj@sgi.com>
Message-ID: <yq0veuq2yeu.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Jackson <pj@sgi.com> writes:

Paul> Andrew wrote:
>> That's OK - it's -ENODEV.

Paul> I can't help but wonder if the particular case of -ENODEV should
Paul> be kept quiet, as in the following totally untested patch:

I'd subscribe to that. It seems a bit wrong to return 0 in a
loadable module if nothing is found, and some of the ones people have
posted patches for converting can be either modules or static.

Cheers,
Jes
