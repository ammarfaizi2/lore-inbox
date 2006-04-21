Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWDURtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWDURtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWDURtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:49:31 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:3489 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751335AbWDURtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:49:31 -0400
Date: Fri, 21 Apr 2006 19:48:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Daniel Walker <dwalker@mvista.com>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Message-ID: <20060421174808.GA1767@wohnheim.fh-wedel.de>
References: <63XWg-1IL-5@gated-at.bofh.it> <63YfP-26I-11@gated-at.bofh.it> <63ZEY-45n-27@gated-at.bofh.it> <4448F97D.5000205@imap.cc> <1145635403.20843.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1145635403.20843.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 April 2006 09:03:23 -0700, Daniel Walker wrote:
> 
> After reviewing some of the callers of kfree(NULL) they appear to be
> errors by the caller .. Where there's some false assumptions going on
> during looping or repeated calls to the same function. 
> 
> I agree with Andrew , I think the calls should be investigated while
> retaining the unlikley() predictor . 

Those calls that frequently call kfree(NULL). ;)

Jörn

-- 
Linux [...] existed just for discussion between people who wanted
to show off how geeky they were.
-- Rob Enderle
