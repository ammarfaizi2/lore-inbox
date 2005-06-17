Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVFQIVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVFQIVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 04:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVFQIVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 04:21:40 -0400
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:52955 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261920AbVFQIVa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 04:21:30 -0400
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <yw1xslzl8g1q.fsf@ford.inprovide.com>
	<Pine.LNX.4.61.0506161036370.30607@chaos.analogic.com>
	<20050616150419.GY23488@csclub.uwaterloo.ca>
	<200506162118.18470.pmcfarland@downeast.net>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 17 Jun 2005 10:21:26 +0200
In-Reply-To: <200506162118.18470.pmcfarland@downeast.net> (Patrick
 McFarland's message of "Thu, 16 Jun 2005 21:18:06 -0400")
Message-ID: <yw1xekb1xuk9.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland <pmcfarland@downeast.net> writes:

> On Thursday 16 June 2005 11:04 am, Lennart Sorensen wrote:
>>  Most people seem happy with 50 or so being a good limit even though many
>>  systems support much longer. 
>
> 50 characters or 50 bytes? Because in the case of UTF-8, if you do a lot of 
> three byte characters (which require four bites to encode), 50 bytes is very 
> short.

What do you mean by three-byte characters requiring four bytes to
encode?  Is a three-byte character not a character encoded using three
bytes?

As for 50 bytes being too short, many of the multibyte characters are
equivalent to several English characters, so fewer of them are
required.  You have a point, though.

-- 
Måns Rullgård
mru@inprovide.com
