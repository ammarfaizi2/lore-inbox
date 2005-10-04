Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVJDXej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVJDXej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 19:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVJDXej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 19:34:39 -0400
Received: from [195.23.16.24] ([195.23.16.24]:40096 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S965032AbVJDXei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 19:34:38 -0400
Message-ID: <20051005003520.h6wvutnlwkgogcok@webmail.grupopie.com>
Date: Wed, 05 Oct 2005 00:35:20 +0100
From: pmarques@grupopie.com
To: Chris Wright <chrisw@osdl.org>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Mathieu Chouquet-Stringer <ml2news@optonline.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13.3 (inconsistent KALLSYMS)
References: <20051004011620.GO16352@shell0.pdx.osdl.net>
	<m33bnhl7ws.fsf@mcs.bigip.mine.nu> <43428D0B.5000205@grupopie.com>
	<20051004213139.GX16352@shell0.pdx.osdl.net>
In-Reply-To: <20051004213139.GX16352@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright <chrisw@osdl.org>:

> * Paulo Marques (pmarques@grupopie.com) wrote:
>> This is probably a known problem that is already fixed in 2.6.14 :(
>
> Yes, given the workaround it hasn't made priority for -stable.

There is a smaller workaround that is just to increase the number of symbols
used to make the compression by changing the "#define WORKING_SET". 
This should
be just a one liner.

The downside of the workaround would be a slightly increased compile time, but
it is not *absolutely* obvious that there are no hidden consequences as is
required for the stable series.

Anyway, since this is just a compile time bug and people compiling 
kernels will
probably search google when this happens and find the patch themselves, 
I don't
think that it is serious enough for -stable, and we might as well hold on a
little more till 2.6.14 is out.

--
Paulo Marques


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

