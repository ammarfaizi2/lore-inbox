Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWHSCCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWHSCCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 22:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWHSCCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 22:02:35 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:26560 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751267AbWHSCCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 22:02:34 -0400
Message-ID: <44E6713C.8060005@novell.com>
Date: Fri, 18 Aug 2006 19:02:36 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
References: <20060730011338.GA31695@sergelap.austin.ibm.com>	 <20060814220651.GA7726@sergelap.austin.ibm.com>	 <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>	 <20060815020647.GB16220@sergelap.austin.ibm.com>	 <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy>
In-Reply-To: <1155615736.2468.12.camel@entropy>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> OTOH, everybody seems to have moved from capability-based security
> models on to TE/RBAC-based security models, so maybe this isn't worth
> the effort?
>   
TE, RBAC, AppArmor, and POSIX.1e Capabilities are all capability-based
systems, in that they all store the security attributes in the principal
(process, program, whatever) rather than the object (the files being
accessed). The difference is in the style of specifying the principals
and objects.

Crispin

-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com
     Hack: adroit engineering solution to an unanticipated problem
     Hacker: one who is adroit at pounding round pegs into square holes

