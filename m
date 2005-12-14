Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVLNNk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVLNNk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVLNNk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:40:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48057 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932524AbVLNNkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:40:25 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <20041214152325.GA2377@ucw.cz>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
	 <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
	 <1133991650.30387.17.camel@localhost>
	 <m18xuwd015.fsf@ebiederm.dsl.xmission.com>  <20041214152325.GA2377@ucw.cz>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 14:40:08 +0100
Message-Id: <1134567609.9442.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 15:23 +0000, Pavel Machek wrote:
> Hi!
> 
> > One of my wish list items would be to run my things like my
> > web browser in a container with only access to a subset of
> > the things I can normally access.  That way I could be less
> > concerned about the latest browser security bug.
> 
> subterfugue.sf.net (using ptrace), but yes, nicer solution
> would be welcome.

selinux too, as well as andrea's syscall filter thing and many others.

the hardest is the balance between security and usability. You don't
want your browser to be able to read files in your home dir (Except
maybe a few selected ones in the browsers own dir)... until you want to
upload a file via a webform.


