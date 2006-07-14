Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWGNRTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWGNRTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbWGNRTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:19:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:49824 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422648AbWGNRTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:19:46 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <20060714170814.GE25303@sergelap.austin.ibm.com>
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
Content-Type: text/plain
Date: Fri, 14 Jul 2006 10:19:39 -0700
Message-Id: <1152897579.24925.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 12:08 -0500, Serge E. Hallyn wrote:
> yes, of course, vfsmount, which I assume is what Eric meant?
> 
> Which means we'd have to do this at permission() using the nameidata, or
> pass nd to generic_permission. 

Yeah, I think so.  But, this is well into Al territory, and there might
be a better way.

-- Dave

