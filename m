Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbUBYH2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbUBYH2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:28:47 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9185 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262656AbUBYH2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:28:44 -0500
Message-ID: <403C4E98.6010107@t-online.de>
Date: Wed, 25 Feb 2004 08:28:24 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040223
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why are 2.6 modules so huge?
References: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov> <yw1x1xokcwfo.fsf@kth.se>
In-Reply-To: <yw1x1xokcwfo.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Seen: false
X-ID: bLdVzTZBYeAPsfVbV1i7iDw1JP3c9TXVeJhD2byv6sA7SodP9I3Gw7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> 
> My 2.6.3 vfat.ko is 15365 bytes.  Maybe you enabled kernel debugging
> symbols.
> 

% ll /lib/modules/2.6.3/kernel/fs/vfat/
total 16
-rw-r--r--    1 root     root        14232 Feb 19 07:43 vfat.ko

Assuming that you are on i686:

A size difference of 1 KByte (about 7%) is remarkable. Which
gcc did you use for building 2.6.3?

I am on Debian (Sid). Gcc is 3.3.3, which was released a
few days ago.


Regards

Harri
