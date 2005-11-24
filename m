Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVKXRPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVKXRPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVKXRPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:15:32 -0500
Received: from main.gmane.org ([80.91.229.2]:30096 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932340AbVKXRPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:15:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: Use enum to declare errno values
Date: Thu, 24 Nov 2005 09:11:38 -0800
Message-ID: <87veyi6kdx.fsf@benpfaff.org>
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-224.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:xdOWIYODsK7a1Q7K7hQm78XPKMg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis <francis_moreau2000@yahoo.fr> writes:

> I'm just wondering why not declaring errno values using enumaration ? It is 
> just more convenient when debuging the kernel.

The C standard says that errno values are macros that expand to
integer constant expressions.  This is important for userspace,
if not for the kernel.
-- 
"Then, I came to my senses, and slunk away, hoping no one overheard my
 thinking."
--Steve McAndrewSmith in the Monastery

