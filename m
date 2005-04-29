Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVD2VAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVD2VAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVD2U7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:59:32 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:41678 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262939AbVD2U4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:56:04 -0400
Message-ID: <42729F4F.2020209@austin.rr.com>
Date: Fri, 29 Apr 2005 15:55:43 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       rml@novell.com
Subject: Re: which ioctls matter across filesystems
References: <42728964.8000501@austin.rr.com> <1114804426.12692.49.camel@lade.trondhjem.org> <1114805033.6682.150.camel@betsy> <1114807360.12692.77.camel@lade.trondhjem.org>
In-Reply-To: <1114807360.12692.77.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>I'm therefore asking whether or not there is a killer-app out there that
>we need to support and that does want to track changes made by other
>clients. File browsers are more or less the only thing that come to
>mind.
>
>Cheers,
>  Trond
>  
>
I believe that the spotlight facility of MacOS, and the somewhat similar 
Longhorn feature (think Google desktop search/indexing on steroids) 
qualify as killer-apps.   I am concerned about how to do better with our 
implementations across a distributed (NFS, CIFS etc.) network.   And of 
course coalescing async notifications most efficiently is a fascinating 
and difficult area to do right - for servers at least.
