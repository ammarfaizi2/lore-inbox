Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUC2Dbd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 22:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUC2Dbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 22:31:32 -0500
Received: from opersys.com ([64.40.108.71]:40713 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262509AbUC2Dbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 22:31:31 -0500
Message-ID: <406799F3.1020508@opersys.com>
Date: Sun, 28 Mar 2004 22:37:23 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: lml@beonline.com.au
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel / Userspace Data Transfer
References: <1080528430.40678e2e9eb3a@www.beonline.com.au>
In-Reply-To: <1080528430.40678e2e9eb3a@www.beonline.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lml@beonline.com.au wrote:
> I have a set of counters in a Kernel module that i want to export to a
> userspace application. I originally decided to use a /proc entry and parse
> the output whenever the userspace application needed this data, however,
> i need more than the 4096 that is allowed in /proc and i'm not too keen
> on parsing large chunks of text anyway.
> 
> What i would like to do is copy these slabs of text from the kernel to my
> userspace application (whenever the application requests it). I've seen the
> 'copy_to_user' function and it looks usefull, but have no idea where to start
> or how to use it :-/
> 
> Can someone provide and example or point me in the right direction? Or is there
> a better place to ask this question?

relayfs has been designed with this type of requirements in mind:
http://www.opersys.com/relayfs/index.html

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

