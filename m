Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUASNM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbUASNM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:12:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60550 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264893AbUASNMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:12:25 -0500
Subject: Re: filesystem bug?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: tsuchiya@labs.fujitsu.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <400B8CD4.8000503@labs.fujitsu.com>
References: <4007537F.4070609@labs.fujitsu.com>
	 <1074256175.4006.24.camel@sisko.scot.redhat.com>
	 <400B8CD4.8000503@labs.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1074517928.3694.22.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jan 2004 13:12:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2004-01-19 at 07:52, Tsuchiya Yoshihiro wrote:

> >OK.  Under exactly what circumstances have you seen this in the past, as
> >opposed to the other problem?  I have not been able to reproduce this
> >one so far.

> Other than 2.4.20-28.9, since they have been running for three days,
> they seems nice at this point.
> 
> What exactly is the race condition between read_inode() and
> clear_inode() you have
> mentioned?

This one:

http://linux.bkbits.net:8080/linux-2.4/patch@1.1136.67.1

Cheers,
 Stephen

