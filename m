Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVBIUHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVBIUHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVBIUHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:07:00 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:62014 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S261912AbVBIUFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:05:36 -0500
Message-ID: <420A6CBA.3050308@spirentcom.com>
Date: Wed, 09 Feb 2005 12:04:10 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fork.c: VM accounting bugfix (2.6.11-rc3-bk5)
References: <20050208230447.V24171@build.pdx.osdl.net>
In-Reply-To: <20050208230447.V24171@build.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Feb 2005 20:05:33.0054 (UTC) FILETIME=[B61AE1E0:01C50EE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
<snip>
> 
> You missed one subtle point.  That failure case actually unaccts 0 pages
> (note the use of charge).  Not the nicest, but I believe correct.
> 

Right.  I did miss that.  Thanks for the explanations, Chris and Hugh, I 
appreciate it.


Mark F. Haigh
Mark.Haigh@spirentcom.com
