Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVAaM5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVAaM5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVAaM5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:57:14 -0500
Received: from mrout2-b.corp.dcn.yahoo.com ([216.109.112.28]:19290 "EHLO
	mrout2-b.corp.dcn.yahoo.com") by vger.kernel.org with ESMTP
	id S261181AbVAaM5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:57:11 -0500
Message-ID: <41FE2B22.1000706@gmail.com>
Date: Mon, 31 Jan 2005 18:27:06 +0530
From: Arun C Murthy <acmurthy@gmail.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Arun C Murthy <acmurthy@gmail.com>
Subject: Accept filtering
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 While browsing through apache core features, I came across 
accept_filtering in FreeBSD - via accf_http which places a filter on a 
socket (setsockopt - SO_ACCEPTFILTER) which  prevents the application 
from receiving the connected descriptor via *accept* until either a full 
HTTP/1.0 or HTTP/1.1 HEAD or GET request has been buffered by the kernel.

 Is there any equivalent for this in Linux? I only came across 
TCP_DEFER_ACCEPT option which only waits till the client sends an ACK 
back to server && first packet of data is recieved (accf_data on 
FreeBSD)...

 ...if there ain't this functionality any tips on how to go about 
implementing it?

thanks,
Arun
