Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWBGWC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWBGWC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWBGWC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:02:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56209 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964882AbWBGWCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:02:25 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 15:00:04 -0700
In-Reply-To: <43E90716.4020208@watson.ibm.com> (Hubertus Franke's message of
 "Tue, 07 Feb 2006 15:46:14 -0500")
Message-ID: <m1bqxide3f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:


> Kirill brought up that VPS can span a cluster..
> if so how do you (Kirill) do that? You pre-partition the pids into allocation
> ranges for each container?
> Eitherway, if this is an important feature, then one needs to look at
> how that is achieved in pspace (e.g. mod the pidmap_alloc() function
> to take legal ranges into account). Should still be straight forward.

Actually legal ranges already exist in the form of min/max values.
So that is trivial to implement.


Eric
