Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTDWOJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTDWOJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:09:33 -0400
Received: from [81.80.245.157] ([81.80.245.157]:12210 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264025AbTDWOJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:09:32 -0400
Date: Wed, 23 Apr 2003 16:21:31 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423142131.GK820@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423135448.GI354@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 09:54:48AM -0400, Ben Collins wrote:

> Your patch leaves a race condition open. And no, I don't have a stripped
> down patch. It's impossible for me to syncronize layers of linux1394
> development with the timing of 2.4/2.5 development. The size of the
> current 2.4 diff is only because of the amount of stuff merged from our
> 2.5 tree and a serious code cleanup (fixing locking problems like you saw
> here).

While this is a reasonable explanation, we are now in rc mode, and 
your changes are not trivial, they could introduce a big pile of
new bugs.

Marcelo, please revert the latest IEEE1394 changeset entirely.

Let's hope that things will happen differently in 2.4.22-pre :(

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
