Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTAaWNj>; Fri, 31 Jan 2003 17:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTAaWNj>; Fri, 31 Jan 2003 17:13:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:18187 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262780AbTAaWNg>;
	Fri, 31 Jan 2003 17:13:36 -0500
Date: Fri, 31 Jan 2003 23:22:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
Message-ID: <20030131222257.GA11011@mars.ravnborg.org>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131213827.GA1541@werewolf.able.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 10:38:27PM +0100, J.A. Magallon wrote:
> So in short, kernel people:
> - do not want perl in the kernel build
Correct, at least for mainstream architectures.
The rationale here is that we already put a lot of constraints on what
tools people need to build a kernel. If we can avoid an extra
_mandatory_ tool then this will make life easier for a lot of people.

For optional features additional requirements are OK, for example
to geneate docbook documentation a lot of extra stuff is needed.

> - allow qt to pollute the kernel to have a decent gui config tool
It would be good to get a replacement, but until that shows up.
Then yes an optional frontend that uses qt is OK.
kconfig is prepared for and one gtk frontend is on the way.
If someone comes up with a decent perl based frontend ten that could be
considered.

> - but perl will be needed anyways
No.

> instead of
> - do all parsing in perl, that is what perl is for and what is mainly done
>   in kconfig scripts
flex and bison is better for this job.

	Sam
