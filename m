Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUHDBk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUHDBk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUHDBk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:40:29 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:45532 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267191AbUHDBkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:40:17 -0400
To: Rik van Riel <riel@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, pbadari@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch] mlock-as-nonroot revisted 
In-reply-to: Your message of Tue, 03 Aug 2004 21:22:45 EDT.
             <Pine.LNX.4.44.0408032122210.5948-100000@dhcp83-102.boston.redhat.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32075.1091583420.1@us.ibm.com>
Date: Tue, 03 Aug 2004 18:37:02 -0700
Message-Id: <E1BsAiE-0008LT-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2004 21:22:45 EDT, Rik van Riel wrote:
> On Tue, 3 Aug 2004, Gerrit Huizenga wrote:
> 
> > DB2, JVM also use hugetlbfs, other uses have been tried with
> > some success.
> 
> OK.  Do any of those do the "root chowns an unnamed
> hugetlbfs file" scenario ? ;)

Badari will probably know the access method for DB2 better than
I do.  I know they go quite out of their way to avoid having
root permissions at any point in time.  How they accomplish this
in the current source base, I don't know.  They were using
capabilities for things like this for a while.

gerrit
