Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUF1Nnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUF1Nnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 09:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUF1Nnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 09:43:35 -0400
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:4307 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S264959AbUF1Nnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 09:43:33 -0400
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
Date: Mon, 28 Jun 2004 09:43:28 -0400
User-Agent: KMail/1.6.2
References: <004e01c45abd$35f8c0b0$b18309ca@home> <40DDEC76.8060101@capitalgenomix.com> <40DE03DF.7090404@sover.net>
In-Reply-To: <40DE03DF.7090404@sover.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280943.28150.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 June 2004 07:16 pm, Stephen Wille Padnos wrote:

> I think you missed one of the main points - you don't get any extra
> space until you mark some of your files as elastic.
> You're right - under this system, nobody would get any space from
> deletion of your files because you would use the system as a normal hard
> quota system - you would mark no files as elastic, and would therefore
> be limited to your quota (in the example you gave, you would not be
> using 110M, because your quota would have limited you to 100M).  If you
> were so kind as to mark something as elastic (say, that recently
> doneloaded install tarball of the Gimp), then you would remove the
> storage taken by those files from your quota usage and would have more
> space available, with the risk that the elastic files might not stick
> around.
>
> Under no circumstance would you lose any file that fits under your quota.

-snip-

> Controlled by you using one of the methods that have been suggested:
> a .elastic file/directory structure
> /scratch/ space usage
> a filesystem that can keep track of these things, and a program like chmod
> xattrs and other userspace tools
>
> etc.
>
> - Steve

It looks (to my untrained eyes) like a user-driven caching "algorithm", where 
I can keep these KDE tarballs around next to the kernel sources, and a few 
shiny new slackware ISOs, and all are of course  replaceable, but I mark them 
elastic or put them in /scratch/... to recover my space at the cost of an 
increased probability that I'll have to download some of them again. I like 
it.

-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
--
