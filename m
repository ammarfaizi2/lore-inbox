Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWCaG2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWCaG2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWCaG2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:28:39 -0500
Received: from anubis.pendulus.net ([38.119.36.60]:58300 "EHLO
	anubis.pendulus.net") by vger.kernel.org with ESMTP
	id S1751095AbWCaG2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:28:39 -0500
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: "Vishal Patil" <vishpat@gmail.com>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
Date: Fri, 31 Mar 2006 01:28:36 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com> <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
In-Reply-To: <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603310128.36991.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance you can diff this against the latest 2.6 kernel ? 2.6.10 is abit 
old.

Thanks

On Thursday 30 March 2006 10:58 pm, Vishal Patil wrote:
> Maintain two queues which will be sorted in ascending order using Red
> Black Trees. When a disk request arrives and if the block number it
> refers to is greater than the block number of the current request
> being served add (merge) it to the first sorted queue or else add
> (merge) it to the second sorted queue. Keep on servicing the requests
> from the first request queue until it is empty after which switch over
> to the second queue and now reverse the roles of the two queues.
> Simple and Sweet. Many thanks for the awesome block I/O layer in the
> 2.6 kernel.
>
> - Vishal
>
> PS: Please note that I have not subscribed to the LKML. For comments
> please reply back to this email.
>
> --
> Every passing minute is another chance to turn it all around.
