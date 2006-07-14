Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbWGNQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWGNQaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWGNQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:30:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:21664 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161142AbWGNQag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:30:36 -0400
Date: Fri, 14 Jul 2006 11:29:35 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060714162935.GA25303@sergelap.austin.ibm.com>
References: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <44B684A5.2040008@fr.ibm.com> <20060713174721.GA21399@sergelap.austin.ibm.com> <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com> <1152815391.7650.58.camel@localhost.localdomain> <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com> <1152821011.24925.7.camel@localhost.localdomain> <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com> <1152887287.24925.22.camel@localhost.localdomain> <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> > On Thu, 2006-07-13 at 21:45 -0600, Eric W. Biederman wrote:
> >> I think for filesystems like /proc and /sys that there will normally
> >> be problems.  However many of those problems can be rationalized away
> >> as a reasonable optimization, or are not immediately apparent.
> >
> > Could you talk about some of these problems?
> 
> Already mentioned but.  rw permissions on sensitive files are for 
> uid == 0.  No capability checks are performed.

As Herbert (IIRC) pointed out that could/should be fixed.

-serge
