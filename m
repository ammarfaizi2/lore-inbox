Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWDRXAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWDRXAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDRXAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:00:25 -0400
Received: from web36612.mail.mud.yahoo.com ([209.191.85.29]:25752 "HELO
	web36612.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750786AbWDRXAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:00:24 -0400
Message-ID: <20060418230023.36553.qmail@web36612.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 18 Apr 2006 16:00:23 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060418195956.GH29302@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:


> The posix caps sendmail fiasco is one example.

Sendmail with POSIX Capabilities works great
on Irix, which is the system it was developed
for. Irix, unlike Linux, supports (but, in
keeping with IEEE rules does not claim to
conform to) the POSIX Capabilities exec(2)
symantics. The sendmail work was done in
anticipation of Linux supporting Posix
Capabilities. Alas, the xattr work on Linux
was not done before the Company The Built Irix
ran out of money to spend on security* and
the push to get capabilities working right
never materialized. Sorry.

----
* I'm not bitter. Oh no, it goes way beyond bitter.


Casey Schaufler
casey@schaufler-ca.com
