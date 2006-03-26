Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWCZTtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWCZTtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 14:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWCZTtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 14:49:08 -0500
Received: from web37702.mail.mud.yahoo.com ([209.191.87.100]:44918 "HELO
	web37702.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751069AbWCZTtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 14:49:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cMbbQ2glD3Qwvu9NN1vzJqO1mXQSVRG6l/dGqxPiMgjVJcYR/lDOus7KEnrQd+YJY3VRazbCttg5OjoeP2oGwAQbgDXBUYebK/w1I6MjiqpytnK/VzS96+ZZmDKO11o5FN/EbuvOOE0rRGdSuSbpeJF9ERRJun4uhAvggQpzyUU=  ;
Message-ID: <20060326194904.24112.qmail@web37702.mail.mud.yahoo.com>
Date: Sun, 26 Mar 2006 11:49:04 -0800 (PST)
From: Edward Chernenko <edwardspec@yahoo.com>
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/3/25, Jan Engelhardt <jengelh@linux01.gwdg.de>:
>
> I dislike this concept. khttpd once tried the same
(moving
> userspace to kernelspace) -- and it's out again.
>

Comparing with khttpd, we have no need to make
transfers between
userspace and kernelspace;  additionally, ident daemon
depends on
kernel connections table. This is very efficient to
avoid using proc
interface by userspace program here.

--
Edward Chernenko <edwardspec@gmail.com>



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
