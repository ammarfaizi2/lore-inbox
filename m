Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268759AbUIQNwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268759AbUIQNwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268760AbUIQNwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:52:19 -0400
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:49316
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S268759AbUIQNwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:52:06 -0400
Message-ID: <414AEC9B.2030807@pbl.ca>
Date: Fri, 17 Sep 2004 08:54:35 -0500
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: argv null terminated in main()?
References: <414A04F6.8040106@pbl.ca> <1095368471.23579.0.camel@localhost.localdomain>
In-Reply-To: <1095368471.23579.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2004-09-16 at 22:26, Aleksandar Milivojevic wrote:
>>The question is, after call to execve() system call, and after new image 
>>is loaded, is argv (as passed to main() function of new program) NULL 
>>terminated or not in Linux?
> 
> Yes. execve is documented in SuS v3 which you can find on the web. See
> also info glibc which does have a lot more information on other useful
> extensions like saved argv0 copies.

Thanks for quick answer.  I didn't know to which degree was Linux SuS v3 
compliant, so I said better to ask ;-)

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
