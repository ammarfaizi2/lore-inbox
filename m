Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTFJU3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTFJU2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:28:38 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:63112 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262409AbTFJU2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:28:06 -0400
Message-ID: <3EE64161.5010102@rackable.com>
Date: Tue, 10 Jun 2003 13:36:49 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Appleby <john@dnsworld.co.uk>
CC: xyko_ig@ig.com.br, linux-kernel@vger.kernel.org
Subject: Re: Wrong number of cpus detected/reported
References: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>
In-Reply-To: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 20:41:47.0646 (UTC) FILETIME=[B647C9E0:01C32F90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Appleby wrote:

>>After the upgrade the system is reporting that the machine has 8 cpu
>>instead of 4. I have been looking for some kind of information on the
>>Internet (www.google.com/linux) about that but I didn't have success.
>>    
>>
>
>I suspect that it is identifying 4 Xeon CPUs with Hyperthreading, which
>will correctly double the amount of processors your kernel thinks you
>have. Intel's Hyperthreading
>
>This ought to be a good thing... the only thing I don't quite understand
>is that I thought Hyperthreading was added in 2.4.17.
>
>  
>

  Red Hat enabled basic hyperthreading support in their 2.4.9 eratta 
kernels some where along the line.  I just didn't think 1.4 Xeons did 
HT.  (Maybe the MP Xeons are different from the DP xeons.)

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


