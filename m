Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVERQlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVERQlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVERQi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:38:59 -0400
Received: from [66.238.194.189] ([66.238.194.189]:30111 "EHLO
	datapower.ducksong.com") by vger.kernel.org with ESMTP
	id S262273AbVERQe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:34:29 -0400
Subject: Re: linux.bkbits.net question: mapping cset to kernel version?
From: patrick mcmanus <mcmanus@ducksong.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <428B4D14.2030104@ammasso.com>
References: <428B4D14.2030104@ammasso.com>
Content-Type: text/plain
Message-Id: <1116434164.28096.9.camel@mcmanus.datapower.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 18 May 2005 12:36:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 10:11, Timur Tabi wrote:
> Given a particular file and a particular bitkeeper revision for the file, how can I tell 
> which version of the kernel incorporated that changeset?
> 
> In particular, I want to know about revision 1.65 of mm/rmap.c, which can be seen at 
> http://linux.bkbits.net:8080/linux-2.6/diffs/mm/rmap.c@1.65?nav=index.html|src/|src/mm|hist/mm/rmap.c
> 
> I want to know what the first version of Linux is to incorporate that change.
> 

The most pragmatic thing to do is to take the comment from the
changeset, which in this case is "mm: get_user_pages vs. try_to_unmap" 
and plop that into google as "changelog mm: get_user_pages vs.
try_to_unmap".. and that will point you very quickly to the right
release changelog that includes it, because the changelogs are generally
driven right from the comments.. in this case

 http://www.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.7-rc3

While this isn't scientific - it has a very high success rate and is
easy as pi..


