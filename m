Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422988AbWBAWr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422988AbWBAWr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422991AbWBAWr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:47:56 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:19467 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1422988AbWBAWr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:47:56 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL V3 and Linux - Dead Copyright Holders
Date: Wed, 1 Feb 2006 14:46:52 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEGPJNAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
In-Reply-To: <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 01 Feb 2006 14:43:35 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 01 Feb 2006 14:43:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:

> but the fact is, the GPL also says that any license notices must be kept
> intact, and that a copy of the GPL itself must be given along with the
> program (in section 1).

	The GPL says you must keep intact notices in the Program that refer to the
license. That logically cannot include the license itself. For one thing,
the license is not in the program. For another thing, the license does not
refer to itself.

> I'm convinced _that_ is how you get "no version specified" in section 9.
> You have a program that just says "This is licensed under the GPL",
> instead of doing the full thing.

	You are essentially arguing here that the FSF screwed up. They intended the
normal case to be that you got a copy of the GPL with the program but could
substitute a later version at your option. Why would they have made it
almost impossible (or even extra-difficult) to get the result that they
preferred?

	A much more logical reading is that the License and the Program are two
distinct things. When it says "notices in the Program", that's precisely
what it means, notices that are in the Program. When it says "the Program
specifies a version number", that's also what it means, a version number
specified by the Program.

	Not only does this make it easy to get the result the FSF preferred, but ot
is supported by the License's internal definition of the term "Program".

	I don't think you can lock a person down to a single version of the GPL
unless you explicitly say so in each individual file. Otherwise, nothing
prevents someone from separating out one file and distributing it, kicking
in clause 9's rule about a Program that does not specify a version number.
The requirement to keep license notices intact does not mean you must add
them or maintain them. Just that you can't remove or modify them.

	It has always been well-understood on this mailing list that a file can be
excerpted from a GPL project and inserted into another one. Surely the FSF
didn't intend to make the default position be that GPL'd projects would be
mutually incompatible.

	DS


