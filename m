Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTJAFjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTJAFjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:39:06 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:32390 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261953AbTJAFi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:38:57 -0400
Date: Wed, 1 Oct 2003 06:38:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001053833.GB1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> Yes. It would kind to tell the pilot about the errata of the engine (and
> refuse to start), rather than telling him that the engine might break
> down anytime after the takeoff.

Doesn't refusing to boot seem to heavy handed for this bug?  The buggy
CPUs have been around for many years (it is practically the entire AMD
line for the last 4 years or so), and nobody in userspace has
complained about the 2.4 behaviour so far.  (Linux 2.4 behaviour is,
of course, to ignore the errata).

ps. Why are we all saying errata - isn't erratum good enough? :)

-- Jamie
