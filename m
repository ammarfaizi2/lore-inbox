Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbSLTV1j>; Fri, 20 Dec 2002 16:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266407AbSLTV1j>; Fri, 20 Dec 2002 16:27:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:37014 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266406AbSLTV1g>; Fri, 20 Dec 2002 16:27:36 -0500
Date: Fri, 20 Dec 2002 13:43:01 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: Hanna Linder <hannal@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       kniht@us.ibm.com
Subject: Re: Dedicated kernel bug database + documentaion
Message-ID: <34640000.1040420581@w-hlinder>
In-Reply-To: <31080000.1040418947@w-hlinder>
References: <200212192155.gBJLtV6k003254@darkstar.example.net> <3E0240CA.4000502@inet.com> <42790000.1040337942@w-hlinder> <50260000.1040348396@flay> <31080000.1040418947@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is my first draft of cleaning up some of the definitions
and adding a FAQ for the kernel tracker bugzilla. Comments
and flames welcome.

Hanna


-------
Status 

OPEN - A new bug that no one is working on.  Bugs in this state may 
be accepted, and become ASSIGNED. The default owner (in charge of tracking
the bug) is the subsystem maintainer or the bugme-janitors mailing list.

ASSIGNED - This bug is assigned to someone who thinks they can fix it. 
>From here bugs typically move to RESOLVED or REJECTED.

RESOLVED - A fix has been made, and it is awaiting more testing. 
>From here bugs are usually either CLOSED or APPROVED.

APPROVED- The fix has been tested. But is not accepted into the mainline
kernel.

REJECTED-The bug has not been fixed. Possible reasons for rejections are
INVALID, DUPLICATE, UNREPRODUCIBLE, or INSUFFICIENT_DATA.
 
DEFERRED- The bug may or may not be fixed later.

CLOSED - The fix has been accepted into the mainline kernel. 

Resolution 

The resolution field indicates what happened to this bug. 

No resolution yet: All bugs which are in one of the "open" states (meaning
the state has no associated resolution) have the resolution set to blank.
All other bugs will be marked with one of the following resolutions. 

CODE_FIX - A fix(patch) for this bug has been generated. 

PATCH_ALREADY_AVAILABLE - This problem has been fixed before and
there is a patch available for it. 

INVALID - The problem described is not a bug. 

WILL_NOT_FIX - The problem described is a bug which will never be
fixed. 

WILL_FIX_LATER - The problem described is a bug which will not be
fixed in this version. 

DUPLICATE - The problem is a duplicate of an existing bug. Marking
a bug duplicate requires the bug number of the duplicate and that number
will be placed in the bug description. 

UNREPRODUCIBLE - All attempts at reproducing this bug were futile,
reading the code produces no clues as to why this behavior would occur. If
more information appears later, please re-assign the bug, for now, file it. 

INSUFFICIENT_DATA - There is not enough information to resolve this bug. 



--------------

	Frequently Asked Questions


Q. How do I know if a bug is being worked on or not?

A. If it is not ASSIGNED to anyone then it is not being worked on.

Q. Why are the subsystem maintainers in kernel tracker sometimes
different than the person listed in the MAINTAINER file?

A. The subsystem maintainers in kernel tracker are volunteers to
help track bugs in an area they are interested in. Sometimes they
are the same person as on kernel.org sometimes they are not. There
are still some categories with no maintainers so more volunteers
are needed.

Q. What does a subsystem maintainer do?

A. He or She will track new bugs and assign them to people or
reject it for various reasons. They periodically check to
make sure things are getting worked on and review fixes to
make sure they are well written.

Q. If a bug has an owner does that mean they are workig on it? 

A. No. If it is not in the ASSIGNED state then no one is working on it.
The owner defaults to the subsytem maintainer. However, anyone
who wants to submit a patch or add more info to a bug can do so.
If the bug is reassigned to someone then the owner field will
reflect that change.

Q. Can anyone add comments to a bug?

A. Yes but you will need to sign up for an account first.

Q. Who can change the status of a bug?

A. Only the subsystem maintainer. If you want to update
a bug put your comments in the comment or attachment fields.

Q. What is the difference between RESOLVED, APPROVED and CLOSED?

A. RESOLVED really should be renamed UNTESTED_FIX. That is
when a fix is available but needs more testing. APPROVED
is very poorly named and should be TESTED_FIX. This is the
last step before CLOSED. CLOSED means the fix has been 
accepted into the mainline kernel.

Q. What would cause a bug to be REJECTED?

A. Probably the two most common reasons are the problem is a DUPLICATE 
of another bug or the report is just badly written and there is not
enough info to do anything about it.
