Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWB0VTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWB0VTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWB0VTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:19:22 -0500
Received: from main.gmane.org ([80.91.229.2]:56200 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751756AbWB0VTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:19:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wes Felter <wesley@felter.org>
Subject: Re: Status of X86_P4_CLOCKMOD?
Date: Mon, 27 Feb 2006 15:17:37 -0600
Message-ID: <dtvqaa$1et$1@sea.gmane.org>
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com> <20060225015722.GC8132@linuxtv.org> <20060225042456.GA7851@redhat.com> <20060225125337.GB8698@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pixpat.austin.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
In-Reply-To: <20060225125337.GB8698@linuxtv.org>
Cc: cpufreq@lists.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:

> If someone has done measurements I'd be interested to
> know the numbers about the actual power savings which
> can be achieved by using P4 clock mod. I don't expect
> it to be much, but I bet it's more than 1W.

Clock modulation can reduce power by 40W on a 3.6GHz Xeon when the 
system is running a high-power application (e.g. Linpack). (It also 
reduces performance by a factor of 6-10). Clock modulation saves no 
power at all during idle.

Wes Felter - wesley@felter.org

