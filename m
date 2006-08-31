Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWHaLNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWHaLNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWHaLNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:13:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:65512 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751450AbWHaLNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:13:10 -0400
Message-ID: <44F6C44D.3040801@in.ibm.com>
Date: Thu, 31 Aug 2006 16:43:17 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Martin Ohlin <martin.ohlin@control.lth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se> <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com> <44F6B80D.2020409@control.lth.se>
In-Reply-To: <44F6B80D.2020409@control.lth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Ohlin wrote:
> Balbir Singh wrote:
> 
>> The CKRM e-series is a PID based CPU Controller. It did a good job of
>> controlling and smoothing out the load (and variations) and even
>> worked with groups. But it achieved all this through some amount of
>> complexity.
> 
> I have now downloaded and looked at the code you refer to. But as far as 
> I can see, the PID controller is only used for load balancing between 
> CPUs, not for controlling the bandwidth/time of individual tasks. Is 
> this correct or did I miss something?
> 
> /Martin

Yes, the PID controller is used for load balancing.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
