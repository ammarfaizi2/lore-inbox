Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTFFSj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTFFSj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:39:58 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:4370 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262176AbTFFSj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:39:57 -0400
Date: Fri, 6 Jun 2003 20:53:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.70] make allmodconfig --> infinite loop
Message-ID: <20030606185329.GA6245@mars.ravnborg.org>
Mail-Followup-To: Andy Pfiffer <andyp@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1054924969.25858.28.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054924969.25858.28.camel@andyp.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 11:42:50AM -0700, Andy Pfiffer wrote:
> It looks like this changeset (via tinyurl.com):
> 
> http://tinyurl.com/dnpr
> 
> causes "make allmodconfig" to go into a silent infinite loop.  The
> changeset immediately before it (on the same bk path -- 1.1259.10.12)
> does not demonstrate the problem.
> 
> Has anyone else seen this?

Hi Andy.

I noticed this as well and Roman Zippel already has posted a fix which is
included in latest-BK from Linus.
The changeset you have identified triggered a bug in kconfig,
which was what Roman fixed.

	Sam
