Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUHZJNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUHZJNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUHZJMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:12:14 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:65214 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267863AbUHZIsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:48:55 -0400
Message-ID: <412DA3F3.8070607@namesys.com>
Date: Thu, 26 Aug 2004 01:48:51 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       George Beshers <gbeshers@comcast.net>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant
 architect in the USA for Phase I of a DARPA funded linux kernel project
References: <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sun, 1 Aug 2004, Hans Reiser wrote:
>
>  
>
>>You can think of this as chroot on steroids.
>>    
>>
>
>Sounds like what you want is pretty much the namespace stuff
>that has been in the kernel since the early 2.4 days.
>
>No need to replicate VFS functionality inside the filesystem.
>
>  
>
It differs in that it has masks (view specifications), they scale well, 
their collection and specification is well automated, and they are 
attached to the process executable rather than in some centralized place 
(that is, they are process oriented not object oriented (traditional) 
and not centralized.  Users without root can use them and be trusted 
with the power to do so.

Hans
