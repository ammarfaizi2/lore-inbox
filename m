Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVANUZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVANUZX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVANUWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:22:55 -0500
Received: from mailhost.ntl.com ([212.250.162.8]:52943 "EHLO
	mta08-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262149AbVANURq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:17:46 -0500
Message-ID: <41E84729.1090209@gentoo.org>
Date: Fri, 14 Jan 2005 22:26:49 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Steve <s.egbert@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-r1 MTRR bug
References: <41E595E9.8040805@sbcglobal.net> <20050112230553.683a813b.akpm@osdl.org>
In-Reply-To: <20050112230553.683a813b.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
> Steve <s.egbert@sbcglobal.net> wrote:
>> For the Athlon 2100, I get the following outputs and then the VGA 
>> console is frozen from further output (but it doesn't prevent the full 
>> bootup into X windows session of which I am able to resume normal 
>> Linux/X session, but not able to regain any virtual console session.)
> 
> 
> hm.  Not sure what could have caused that.

This may be a problem in Gentoo's kernels, we offer an experimental version of 
vesafb...

>> mtrr: size and base must be multiples of 4kiB  (<<-- this line is 
>> repeated 20 times).
> 
> 
> Could you add this so we can track down the culprit?

I got another user who reported the same problem to test the patch, the result is:
http://bugs.gentoo.org/attachment.cgi?id=48451
(original bug http://bugs.gentoo.org/77674)

I will confirm whether or not this is a gentoo-specific problem or not and let 
you know.

Daniel
