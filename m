Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWGOPy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWGOPy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 11:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWGOPy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 11:54:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:2263 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750716AbWGOPy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 11:54:28 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m1d5c7qc55.fsf@ebiederm.dsl.xmission.com>
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	 <1152815391.7650.58.camel@localhost.localdomain>
	 <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	 <1152821011.24925.7.camel@localhost.localdomain>
	 <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	 <1152887287.24925.22.camel@localhost.localdomain>
	 <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	 <20060714162935.GA25303@sergelap.austin.ibm.com>
	 <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	 <1152896138.24925.74.camel@localhost.localdomain>
	 <20060714170814.GE25303@sergelap.austin.ibm.com>
	 <1152897579.24925.80.camel@localhost.localdomain>
	 <m17j2gt7fo.fsf@ebiederm.dsl.xmission.com>
	 <1152900911.5729.30.camel@lade.trondhjem.org>
	 <m1hd1krpx6.fsf@ebiederm.dsl.xmission.com>
	 <1152911079.5729.70.camel@lade.trondhjem.org>
	 <m1psg7qzjl.fsf@ebiederm.dsl.xmission.com>
	 <4DBD2EBA-9AE2-4598-A9E5-FE7ADCA60B44@mac.com>
	 <m1d5c7qc55.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 08:54:20 -0700
Message-Id: <1152978860.314.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 06:35 -0600, Eric W. Biederman wrote:
> Currently there are several additional flags that could benefit
> from a per vfsmount interpretation as well:  nosuid, noexec, nodev,
> and readonly, how do we handle those?
> 
> noexec is on the vfsmount.
> nosuid is on the vfsmount
> nodev  is on the vfsmount
> readonly is not on the vfsmount.

I can help with one of them:

http://www.opensubscriber.com/message/linux-kernel@vger.kernel.org/4437187.html

A rollup is here (it includes other things, though)

http://www.sr71.net/patches/2.6.18/2.6.18-rc1-mm1-lxc4/

-- Dave

