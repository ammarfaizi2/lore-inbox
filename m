Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTIARpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbTIARpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:45:32 -0400
Received: from [200.181.138.124] ([200.181.138.124]:61880 "EHLO
	oops.kerneljanitors.org") by vger.kernel.org with ESMTP
	id S263195AbTIARpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:45:12 -0400
Date: Mon, 1 Sep 2003 14:44:37 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Philip Clark <pclark@SLAC.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: orinoco wireless driver
Message-ID: <20030901174437.GK10584@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Philip Clark <pclark@SLAC.Stanford.EDU>, linux-kernel@vger.kernel.org
References: <x34vfscwgq8.fsf@bbrcu5.slac.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x34vfscwgq8.fsf@bbrcu5.slac.stanford.edu>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 01, 2003 at 10:39:27AM -0700, Philip Clark escreveu:
> Hi Everyone, 
> 
> My wireless card is not working in the new test4 kernel. It appears the
> driver is broken and the card gets detected as a memory card and the
> kernel module memory_cs tries to get loaded instead. Does anyone know
> if there is a fix for this?

humm, I saw this lots of times, care to try, after it is detected as "memory"
to do this:

cardctl eject
cardctl insert

and see if gets correctly detected this turn? works for me.

- Arnaldo
