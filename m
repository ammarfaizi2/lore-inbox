Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUGGMbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUGGMbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbUGGMbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:31:50 -0400
Received: from apegate.roma1.infn.it ([141.108.7.31]:10369 "EHLO apona.ape")
	by vger.kernel.org with ESMTP id S265086AbUGGMbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:31:49 -0400
Message-ID: <40EBED33.3050707@roma1.infn.it>
Date: Wed, 07 Jul 2004 14:31:47 +0200
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
References: <200407011215.59723.bjorn.helgaas@hp.com> <20040701115339.A4265@unix-os.sc.intel.com>
In-Reply-To: <20040701115339.A4265@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah wrote:

> What type of usage model did you have in mind to have the
>
>device write to memory instead of using MSI for interrupts?
>  
>
for instance for a fast wake-up trick. the driver loops on a memory 
location until the MSI write access changes the memory content...

