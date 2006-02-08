Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWBHEsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWBHEsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWBHEsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:48:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8854 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030328AbWBHEsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:48:35 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Hubertus Franke <frankeh@watson.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: The issues for agreeing on a virtualization/namespaces
 implementation.
References: <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
	<43E92EDC.8040603@watson.ibm.com>
	<20060208004325.GA15061@ms2.inr.ac.ru>
	<m1k6c6bm57.fsf@ebiederm.dsl.xmission.com>
	<20060208033633.GA8784@sergelap.austin.ibm.com>
	<m1d5hybj80.fsf@ebiederm.dsl.xmission.com>
	<20060208043721.GA26692@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 21:46:26 -0700
In-Reply-To: <20060208043721.GA26692@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Wed, 8 Feb 2006 05:37:21 +0100")
Message-ID: <m1u0baa259.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> yep, that's what the first network virtualization for
> Linux-VServer aimed at, but found too complicated
> the second one uses 'pairs' of communicating devices
> to send between guests/host

Well you need the pairs of course, to communication between
the two stack ``instances''.

>> With that rule dealing with the network stack is just a matter of
>> making some currently global variables/data structures per container.
>
> yep, like the universal loopback and so ...

:)

Eric
