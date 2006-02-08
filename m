Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWBHBF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWBHBF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWBHBF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:05:26 -0500
Received: from atlas.pnl.gov ([130.20.248.194]:986 "EHLO atlas.pnl.gov")
	by vger.kernel.org with ESMTP id S1030347AbWBHBFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:05:24 -0500
Date: Tue, 07 Feb 2006 18:08:03 -0800
From: Kevin Fox <Kevin.Fox@pnl.gov>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
In-reply-to: <43E92602.8040403@vilain.net>
To: Sam Vilain <sam@vilain.net>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, Rik van Riel <riel@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Message-id: <1139364483.7169.20.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <43E7C65F.3050609@openvz.org>
 <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
 <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
 <43E92602.8040403@vilain.net>
X-OriginalArrivalTime: 08 Feb 2006 01:05:22.0695 (UTC)
 FILETIME=[BCB78170:01C62C4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 11:58 +1300, Sam Vilain wrote:
> Hubertus Franke wrote:
> > The container is just an umbrella object that ties every "virtualized" 
> > subsystem together.
> 
> I like this description; it matches roughly with the concepts as
> presented by vserver; there is the process virtualisation (vx_info), and
> the network virtualisation (nx_info) of Eric's that has been integrated
> to the vserver 2.1.x development branch.  However the vx_info has become
> the de facto umbrella object space as well.  These could almost
> certainly be split out without too much pain or incurring major
> rethinks.
> 
> Sam.

How does all of this tie in with CPU Sets? It seems to me, they have
something not unlike a container already that supports nesting.

Kevin

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
