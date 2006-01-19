Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161309AbWASKDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWASKDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWASKDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:03:13 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:13231 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1161309AbWASKDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:03:12 -0500
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, "Bryan O'Sullivan" <bos@pathscale.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Why is wmb() a no-op on x86_64?
References: <1137601417.4757.38.camel@serpentine.pathscale.com>
	<1137603169.4757.50.camel@serpentine.pathscale.com>
	<yq04q41qxcw.fsf@jaguar.mkp.net> <200601181831.01688.ak@suse.de>
From: Jes Sorensen <jes@sgi.com>
Date: 19 Jan 2006 05:03:11 -0500
In-Reply-To: <200601181831.01688.ak@suse.de>
Message-ID: <yq0hd807cww.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@suse.de> writes:

Andi> On Wednesday 18 January 2006 18:06, Jes Sorensen wrote:
>>  A job for mmiowb() perhaps?

Andi> No, normal IO mappings are also not write combining on x86, so
Andi> it's not needed there.

True, just seemed nasty to have yet another special purpose wmb()
variation.

Cheers,
Jes
