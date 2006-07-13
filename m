Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWGMSX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWGMSX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWGMSX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:23:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11725 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030276AbWGMSX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:23:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<44B3D435.8090706@sw.ru> <m1k66jebut.fsf@ebiederm.dsl.xmission.com>
	<44B4D970.90007@sw.ru> <m164i2ae3m.fsf@ebiederm.dsl.xmission.com>
	<44B67C4B.7050009@fr.ibm.com>
Date: Thu, 13 Jul 2006 12:21:49 -0600
In-Reply-To: <44B67C4B.7050009@fr.ibm.com> (Cedric Le Goater's message of
	"Thu, 13 Jul 2006 19:00:59 +0200")
Message-ID: <m1irm11i2q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok.  Stepping back a little ways.

We need a formula for doing incremental development that will allow us to
make headway while not seeing the entire picture all at once.  The scope
is just too large.

The usual pattern is for someone to do implement the code in the order
and the fashion that seems obvious and then to reimplement it with a
history that is aids code reviews, and makes it obvious what is
happening.  The reimplementation results in the exact same code but
the steps to get there are different.

We can either do that as individuals or as a group.  But that
is the only pattern I know of that allows us to be comprehensive
when we merge and fall short during development.

Eric
