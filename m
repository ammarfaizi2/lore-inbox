Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264280AbTICSg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTICSgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:36:32 -0400
Received: from 24-193-66-245.nyc.rr.com ([24.193.66.245]:55425 "EHLO
	siri.morinfr.org") by vger.kernel.org with ESMTP id S264280AbTICSeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:34:00 -0400
Date: Wed, 3 Sep 2003 14:35:07 -0400
From: Guillaume Morin <guillaume@morinfr.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: James Clark <jimwclark@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030903183507.GI905@siri.morinfr.org>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	James Clark <jimwclark@ntlworld.com>, linux-kernel@vger.kernel.org
References: <200309031850.14925.jimwclark@ntlworld.com> <Pine.LNX.4.10.10309031043410.13722-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.10.10309031043410.13722-100000@master.linux-ide.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans un message du 03 Sep à 10:49, Andre Hedrick écrivait :
> The only solution is to created a GPL pre-loading module with all the
> GPL_ONLY needed extentions re-exported or externed as to bypass the
> horse sh*t.

Which would be a violation of the GPL :

What is the difference between "mere aggregation" and "combining two
modules into one program"?  

   Mere aggregation of two programs means putting them side by side on
the same CD-ROM or hard disk. We use this term in the case where they
are separate programs, not parts of a single program. In this case, if
one of the programs is covered by the GPL, it has no effect on the other
program.

    Combining two modules means connecting them together so that they form a
single larger program. If either part is covered by the GPL, the whole
combination must also be released under the GPL--if you can't, or won't, do
that, you may not combine them.

    What constitutes combining two parts into one program? This is a legal
question, which ultimately judges will decide. We believe that a proper
criterion depends both on the mechanism of communication (exec, pipes, rpc,
function calls within a shared address space, etc.) and the semantics of the
communication (what kinds of information are interchanged).

    If the modules are included in the same executable file, they are
definitely combined in one program. If modules are designed to run linked
together in a shared address space, that almost surely means combining them
into one program.

    By contrast, pipes, sockets and command-line arguments are communication
mechanisms normally used between two separate programs. So when they are used
for communication, the modules normally are separate programs. But if the
semantics of the communication are intimate enough, exchanging complex internal
data structures, that too could be a basis to consider the two parts as
combined into a larger program.

-- 
Guillaume Morin <guillaume@morinfr.org>

     Tu veux que les gens réagissent ? Alors commence par réagir (Lofofora)
