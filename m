Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWDYQne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWDYQne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWDYQnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:43:33 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:23717 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751613AbWDYQnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:43:32 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060425042542.53414.qmail@web36603.mail.mud.yahoo.com>
References: <20060425042542.53414.qmail@web36603.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 12:47:55 -0400
Message-Id: <1145983675.21399.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 21:25 -0700, Casey Schaufler wrote:
> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> 
> > Seems like a strawman.  We aren't claiming that
> > SELinux is perfect, and
> > there is plenty of work ongoing on SELinux
> > usability.  But a
> > fundamentally unsound mechanism is more dangerous
> > than one that is never
> > enabled; at least in the latter case, one knows
> > where one stands.  It is
> > the illusory sense of security that accompanies
> > path-based access
> > control that is dangerous.
> 
> I suggest that this logic be applied to
> the "strict policy", "targeted policy",
> and "user written policy" presentations
> of SELinux. You never know what the policy
> might be.

Whatever policy you have, that policy is at least analyzable, and tools
exist for analyzing it for information flow as well as for direct
relationships.  In the absence of complete mediation and unambiguous
identifiers, you can't do any analysis at all, so you never know whether
you have achieved your goal.

-- 
Stephen Smalley
National Security Agency

