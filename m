Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSG2VJc>; Mon, 29 Jul 2002 17:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318177AbSG2VJc>; Mon, 29 Jul 2002 17:09:32 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.200]:45804 "EHLO
	moutvdomng3.kundenserver.de") by vger.kernel.org with ESMTP
	id <S318176AbSG2VJc>; Mon, 29 Jul 2002 17:09:32 -0400
Date: Mon, 29 Jul 2002 23:12:05 +0200
From: Stefan Kleyer <stefan@kleyer.net>
To: grendel@caudium.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc3-ac4 parse error
Message-Id: <20020729231205.7f46b121.stefan@kleyer.net>
In-Reply-To: <20020729203910.GA1722@thanes.org>
References: <20020729221759.1576dd0d.kleyer@foni.net>
	<20020729203910.GA1722@thanes.org>
Organization: TUX WE TRUST
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002 22:39:10 +0200
Marek Habersack <grendel@caudium.net> wrote:

> My guess is that you're using gcc 2.95 possibly from Debian? (Other
> distros might be affected too, I don't know). The cpp shipped with the
> Debian's gcc 2.95-15 doesn't parse the ##arg part of the varargs macro
> DRM_ERROR (or any other) for that matter. It is supposed, per docs, to
> remove the comma should the variable args (the "rest") be empty - it
> leaves the comma there instead, which renders incorrect C code. I have
> submitted the bug to the Debian gcc maintainers.

gcc -v says: 
"Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)"
Shipped with Slackware 8.1
and the -ac3 was compiled without errors

Bye,  Stefan
