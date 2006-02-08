Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWBHPRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWBHPRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWBHPRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:17:31 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9655 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030423AbWBHPRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:17:30 -0500
Date: Wed, 8 Feb 2006 09:17:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
Message-ID: <20060208151726.GA28602@sergelap.austin.ibm.com>
References: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com> <43EA02D6.30208@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EA02D6.30208@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hubertus Franke (frankeh@watson.ibm.com):
> Eric W. Biederman wrote:
> So it seems the clone( flags ) is a reasonable approach to create new
> namespaces. Question is what is the initial state of each namespace?
> In pidspace we know we should be creating an empty pidmap !
> In network, someone suggested creating a loopback device
> In uts, create "localhost"
> Are there examples where we rather inherit ?  Filesystem ?

Of course filesystem is already implemented, and does inheret a full
copy.

-serge
