Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030601AbWBHUWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030601AbWBHUWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWBHUWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:22:19 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:65413 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751142AbWBHUWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:22:19 -0500
Subject: Re: The issues for agreeing on a virtualization/namespaces
	implementation.
From: Dave Hansen <haveblue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, kuznet@ms2.inr.ac.ru, saw@sawoct.com,
       devel@openvz.org, Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
In-Reply-To: <20060208180309.GA20418@sergelap.austin.ibm.com>
References: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	 <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	 <20060207201908.GJ6931@sergelap.austin.ibm.com>
	 <43E90716.4020208@watson.ibm.com>
	 <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
	 <43E92EDC.8040603@watson.ibm.com>
	 <m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com> <43EA02D6.30208@watson.ibm.com>
	 <20060208180309.GA20418@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 12:21:39 -0800
Message-Id: <1139430099.9452.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 12:03 -0600, Serge E. Hallyn wrote:
> Now I believe Eric's code so far would make it so that you can only
> refer to a namespace from it's *creating* context.  Still restrictive,
> but seems acceptable.

The same goes for filesystem namespaces.  You can't see into random
namespaces, just the ones underneath your own.  Sounds really reasonable
to me.

-- Dave

