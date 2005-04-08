Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVDHS30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVDHS30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVDHS30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:29:26 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:31444 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262925AbVDHS3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:29:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=No8YxRgA5Fefp/8ithpyXyqYWLYQvWE/Fgrmv7Ke2tWQ+oVUWN8uBGx+al38ajsJaoAFlcs1BB3hw5Zm0zgcbqQl9U2qJDjRtmeNzfgRL2licYNYXygBSx6qIpsPYdn4i7KxjvprBn4mTZ/lq5c5AO69OaLISUUZ7ULnvQEqNbU=
Message-ID: <9e473391050408112865ed5d17@mail.gmail.com>
Date: Fri, 8 Apr 2005 14:28:59 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel SCM saga..
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <20050408041341.GA8720@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	 <20050408071428.GB3957@opteron.random>
	 <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
	 <4256AE0D.201@tiscali.de>
	 <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
	 <4256BE7D.5040308@tiscali.de>
	 <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 8, 2005 2:14 PM, Linus Torvalds <torvalds@osdl.org> wrote:
>    How do you replicate your database incrementally? I've given you enough
>    clues to do it for "git" in probably five lines of perl.

Efficient database replication is achieved by copying the transaction
logs and then replaying them. Most mid to high end databases support
this. You only need to copy the parts of the logs that you don't
already have.

-- 
Jon Smirl
jonsmirl@gmail.com
