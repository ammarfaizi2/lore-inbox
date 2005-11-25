Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbVKYAQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbVKYAQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 19:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVKYAQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 19:16:20 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:58785 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161077AbVKYAQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 19:16:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Piotr Majka <charvel@link.pl>
Subject: Re: PROBLEM: bind-9.3.1 doesnt work with 2.6.14
Date: Fri, 25 Nov 2005 11:16:03 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200511251057.06263.kernel@kolivas.org> <Pine.LNX.4.63.0511250100590.19047@link.pl>
In-Reply-To: <Pine.LNX.4.63.0511250100590.19047@link.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251116.03445.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2005 11:09, Piotr Majka wrote:
> After run named on 2.6.14 (I try 2.6.14-rcX too) I got in logfile:
>
> Nov 10 18:24:57 xxx named[1845]: errno2result.c:109: unexpected error:
> Nov 10 18:24:57 xxx named[1845]: unable to convert errno to isc_result:
> 14: Bad address
> Nov 10 18:24:57 xxx named[1845]: UDP client handler shutting down due to
> fatal receive error: unexpected error
>
> and named dont respond to the query. I switch back to 2.6.13.2 - all
> work fine. Once again run 2.6.14 - the same error after few minutes of
> working.

Known problem, fixed in 2.6.14.2 onwards.

Cheers,
Con
