Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUDOWDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUDOWDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:03:50 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:25838 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262235AbUDOWDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:03:48 -0400
Message-ID: <407F06BD.3010905@nortelnetworks.com>
Date: Thu, 15 Apr 2004 18:03:41 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Fabian Frederick <Fabian.Frederick@skynet.be>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS proc entry
References: <1082060754.9112.2.camel@bluerhyme.real3> <1082065633.7141.52.camel@lade.trondhjem.org>
In-Reply-To: <1082065633.7141.52.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> På to , 15/04/2004 klokka 13:25, skreiv Fabian Frederick:

>>	Do we have some /proc entry for realtime NFS access point report /
>>client like showmount does with RPC ?

> Exactly what possible justification would there be for putting something
> like that into the kernel?

I agree with you that it's kind of messy to put this in the kernel.

However, with the current setup filesystem monitoring deamons must fork 
off a child for each mount, since statfs() can block for many seconds if 
the server has gone away.


Chirs
