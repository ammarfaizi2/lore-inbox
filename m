Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTH2Gyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 02:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTH2Gyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 02:54:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:392 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S264434AbTH2Gy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 02:54:26 -0400
Date: Fri, 29 Aug 2003 07:53:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Daniel Egger <degger@fhm.edu>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, herbert@13thfloor.at,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: UP optimizations ..
Message-ID: <20030829065332.GA12978@mail.jlokier.co.uk>
References: <20030827160315.GD26817@www.13thfloor.at> <16204.62914.298711.293389@gargle.gargle.HOWL> <1062058995.965.2.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062058995.965.2.camel@sonja>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> Shouldn't these be marked const?

  1. There's no need, because they are inline and simple enough to optimise.

  2. GCC seems to ignore const and pure attributes on inline functions,
     even when that would enable optimisation that it cannot see from the
     function body.


-- Jamie
