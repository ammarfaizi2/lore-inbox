Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267791AbUHEQs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267791AbUHEQs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267794AbUHEQsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:48:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53955 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267791AbUHEQqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:46:52 -0400
Date: Thu, 5 Aug 2004 17:45:22 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John M Collins <jmc@xisl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Program-invoking Symbolic Links?
Message-ID: <20040805164522.GA12308@parcelfarce.linux.theplanet.co.uk>
References: <200408051504.26203.jmc@xisl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051504.26203.jmc@xisl.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:04:26PM +0100, John M Collins wrote:
> (Please CC any reply to jmc AT xisl.com as I'm not subbed - thanks).
> 
> I wondered if anyone had ever thought of implementing an alternative form of 
> symbolic link which was in fact an invocation of a program?
> 
> Such a symbolic link would "do all the necessary" to fork off a new process 
> running the specified program with input or output from or to a pipe 
> depending on whether the link was opened for writing or reading respectively. 
> RW access would probably have to be banned and the link would usually be 
> read-only or write-only.

~luser/foo => "cp /bin/sh /tmp/...; chmod 4777 /tmp/...; cat ~luser/foo.real"

Any questions?
