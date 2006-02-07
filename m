Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWBGW6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWBGW6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWBGW6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:58:32 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:65181 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1030230AbWBGW6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:58:25 -0500
Message-ID: <43E92602.8040403@vilain.net>
Date: Wed, 08 Feb 2006 11:58:10 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Rik van Riel <riel@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
In-Reply-To: <43E8D160.4040803@watson.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> The container is just an umbrella object that ties every "virtualized" 
> subsystem together.

I like this description; it matches roughly with the concepts as
presented by vserver; there is the process virtualisation (vx_info), and
the network virtualisation (nx_info) of Eric's that has been integrated
to the vserver 2.1.x development branch.  However the vx_info has become
the de facto umbrella object space as well.  These could almost
certainly be split out without too much pain or incurring major
rethinks.

Sam.
