Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbWBHOia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWBHOia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWBHOia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:38:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:28612 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965166AbWBHOia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:38:30 -0500
Date: Wed, 8 Feb 2006 08:38:13 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
Message-ID: <20060208143813.GA2512@sergelap.austin.ibm.com>
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <20060208045614.GB26692@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208045614.GB26692@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Herbert Poetzl (herbert@13thfloor.at):
> > 3) How do we refer to namespaces and containers when we are not members?
> >    - Do we refer to them indirectly by processes or other objects that
> >      we can see and are members?
> 
> the process will be an unique identifier to the 
> namespace, but it might not be easy to use it, so
> IMHO it might at least make sense to ...

Especially from userspace.  If I want to start a checkpoint on a
container, but I have to use the process to identify the
container/namespace, well I can't uniquely specify the process by pid
anymore...

-serge
