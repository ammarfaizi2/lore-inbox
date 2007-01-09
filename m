Return-Path: <linux-kernel-owner+w=401wt.eu-S1751311AbXAIKmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXAIKmE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbXAIKmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:42:03 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33591 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbXAIKmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:42:00 -0500
Message-ID: <45A37176.9050607@garzik.org>
Date: Tue, 09 Jan 2007 05:41:58 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] sata_nv: add suspend/resume support v3 (Resubmit)
References: <459C46C5.5050407@shaw.ca>
In-Reply-To: <459C46C5.5050407@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Thoughts from Jeff & company on merging the patch below into libata-dev? 
> This has been in the -mm tree for over a month now, I haven't heard any 
> complaints about regressions..
> 
> ---
> 
> From: Robert Hancock <hancockr@shaw.ca>
> 
> This patch adds the necessary callbacks to support suspend/resume properly
> in sata_nv.  Most of the controllers don't need any specific handling but
> CK804/MCP04 controllers, whether ADMA is enabled or not, need some
> additional setup on resume.
> 
> As well as the additional storage of the controller type needed for proper
> resume handling, this also removes the inline helper functions for getting
> ADMA register locations by storing the pointers so we don't have to keep
> calculating them all the time.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

applied


