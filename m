Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264800AbUEESGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264800AbUEESGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 14:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbUEESGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 14:06:31 -0400
Received: from opersys.com ([64.40.108.71]:15625 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S264800AbUEESG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 14:06:28 -0400
Message-ID: <40992E7F.3070006@opersys.com>
Date: Wed, 05 May 2004 14:12:15 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enhanced Linux System Accounting
References: <4098EB80.2060908@bull.net>
In-Reply-To: <4098EB80.2060908@bull.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guillaume Thouvenin wrote:
>     This patch is just a beginning and currently it allows to group
> process together in a "bank" via /dev/elsacct device using ioctl(). 
> Also, it allows to recover accounting informations (taken from BSD 
> accounting for the moment) about a "bank".  We also provide a C program 
> called elsa_cmd.c that "plays" with ioctl() to manage banks. This 
> program can be found at

Maybe you want to consider using relayfs instead of implementing yet
another mechanism for transfering data from kernel space to user-space:
http://www.opersys.com/relayfs/index.html

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

