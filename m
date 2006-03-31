Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWCaBLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWCaBLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWCaBLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:11:38 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:63683 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751130AbWCaBLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:11:37 -0500
Date: Thu, 30 Mar 2006 19:11:24 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: cannot get clean 2.4.20 kernel to compile
In-reply-to: <5W8lY-1wF-29@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: George P Nychis <gnychis@cmu.edu>
Message-id: <442C81BC.7030605@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5W8lY-1wF-29@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George P Nychis wrote:
> Hi,
> 
> I have downloaded the 2.4.20 kernel from ftp.kernel.org, have checked its sign, and no matter what I try I cannot get it to compile.
> 
> I do a make mrproper, I then do make dep which is fine, but then i try "make bzImage modules modules_install", selecting all the defaults, and get an SMP header error:
> http://rafb.net/paste/results/QzIq7v86.html
> 
> I then disable SMP support and get:
> http://rafb.net/paste/results/muYA9t12.html
> 
> I even tried using my config from the 2.4.32 kernel which works perfectly fine, and I also get the sched errors.

What gcc version? Some old kernels might not be buildable with newer 
compilers.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

