Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVFVRpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVFVRpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVFVRno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:43:44 -0400
Received: from main.gmane.org ([80.91.229.2]:7858 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261818AbVFVRlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:41:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: Cpu utilization per thread
Date: Wed, 22 Jun 2005 13:41:48 -0400
Message-ID: <d9c7dt$9dk$1@sea.gmane.org>
References: <07f701c5765f$cd437cd0$99bcc68a@blr.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <07f701c5765f$cd437cd0$99bcc68a@blr.st.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

N Chandra Shekhar REDDY wrote:
> Hi all,
> Can any body tell me 
> How to find cpu utilization per thread excluding wait times and sleep times?
> Regards
> ncs
> 

man 5 proc

The thread stuff is in the /proc/<pid>/tasks subdirectory but I think
the status is process specific not thread specific.

--
Joe Seigh

