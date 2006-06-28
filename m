Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932835AbWF1PVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbWF1PVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932836AbWF1PVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:21:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26275 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932830AbWF1PVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:21:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk
Subject: Re: [RFC] Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<44A25802.3030006@fr.ibm.com>
Date: Wed, 28 Jun 2006 09:20:26 -0600
In-Reply-To: <44A25802.3030006@fr.ibm.com> (Cedric Le Goater's message of
	"Wed, 28 Jun 2006 12:20:50 +0200")
Message-ID: <m164ilgvd1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> How that proposal differs from the initial Daniel's patchset ? how far was
> that patchset to reach a similar agreement ?

My impression is as follows.  The OpenVz implementation and mine work
on the same basic principles of handling the network stack at layer 2.

We have our implementation differences but the core ideas are about the
same.

Daniels patch still had elements of layer 3 handling as I recall
and that has problems.

> OK, i wear blue socks :), but I'm not advocating a patchset more than
> another i'm just looking for a shorter path.

Besides laying the foundations.  The current conversation seems to be
about understanding the implications of the network stack when
we implement a network namespace.

There is a lot to the networking stack so it takes a while.
In addition this is one part of the problem that everyone has implemented,
so we have several more opinions on how it should be done and what
needs to happen.

Eric
