Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVDBCMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVDBCMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbVDBCMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:12:14 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:6413 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261650AbVDBCMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:12:05 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Fri, 1 Apr 2005 18:11:18 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGENHCNAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
In-Reply-To: <20050330141550.GA71637@dspnet.fr.eu.org>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 01 Apr 2005 18:10:34 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 01 Apr 2005 18:10:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Tue, Mar 29, 2005 at 11:00:30AM -0800, David Schwartz wrote:

> > Since the GPL permits their removal, removing them cannot
> > be circumventing
> > the GPL. Since the GPL is the only license and the license
> > permits you to
> > remove them, they cannot be a license enforcement mechanism. How can you
> > enforce a license that permits unrestricted functional modification?

> You misunderstand totally the EXPORT_GPL system.

	No, I understand it perfectly.

> It does not mean
> "this is a technological system to prevent you to use it with non-gpl
> compatible code".

	Right, which is precisely what I said. They are not a license enforcement
mechanism.

> It means "The author of that code consider that
> using this function makes your code so linux-specific that it must be
> a derivative work of the code implementing the function, so if you use
> it from non gpl-compatible code you'll be sued.  And since he's nice,
> he uses a technical method to prevent you from doing such a copyright
> violation by mistake.".

	If the author of the code is not a lawyer, his opinion about what does or
does not constitute a derived work should really not be of any interest. I
do agree that this is much closer to an accurate understandinf of EXPORT_GPL
than that it's a license enforcement mechanism.

> See the subtle difference?  EXPORT_GPL is here to _help_ proprietary
> driver authors.  Your lawyers should _love_ it and skin you alive if
> you try to get around it.

	Why would any competent lawyer perfer the opinion of a layperson on a
purely legal matter over his own opinion? That's totally absurd.

	In any event, I wasn't talking about what EXPORT_GPL is, just about what it
isn't. And you seem to agree with me that it's not a license enforcement
mechanism and that you're not violating the GPL if you remove it and
distribute the results.

	I hope you would further agree that the legality of distributing code not
under the GPL that uses EXPORT_GPL symbols hinges on whether the works
distributed actually *are* derivative works of the covered works and not on
the author's opinion. Neither the authors of GPL'd works nor the GPL can set
out the scope of the GPL's authority -- that comes from copyright law.

	DS


