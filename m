Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWAUCHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWAUCHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWAUCHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:07:04 -0500
Received: from web34106.mail.mud.yahoo.com ([66.163.178.104]:57019 "HELO
	web34106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932162AbWAUCHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:07:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Fn7jkHquUuq66OA65UooAAYmkzENhZKnP0APmuSq80GIvL341t6vHHIFw03lVBfVAuYobGvCjVYUj0zT78eyaXOJfjTdOmTRcH+laDEkTwdsCIFexRkJeF4Zgr+Yxe6qyU0Lm0heWviGx1RV6X5rFlwiBNabzLUcqRl+uqTJmR4=  ;
Message-ID: <20060121020702.76078.qmail@web34106.mail.mud.yahoo.com>
Date: Fri, 20 Jan 2006 18:07:02 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: set_bit() is broken on i386?
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some day I'll learn to wait a few minutes before posting...

Is the issue here because btsl can touch many different bytes in the array, and there is no easy
way to tell gcc that an array is in-out, so "memory" is the best we can do?

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
