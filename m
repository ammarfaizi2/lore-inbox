Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTFJUmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTFJUmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:42:23 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:57519 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S264095AbTFJUmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:42:13 -0400
Message-ID: <3EE648D8.7000500@techsource.com>
Date: Tue, 10 Jun 2003 17:08:40 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: xyko_ig@ig.com.br, linux-kernel@vger.kernel.org
Subject: Re: Wrong number of cpus detected/reported
References: <MDEHLPKNGKAHNMBLJOLKGECIDJAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Schwartz wrote:

> 
> 	This is correct. The machine has 8 logical CPUs implemented inside 4
> physical CPUs. For more information, search Intel's web pages about
> 'hyperthreading'.
> 


But if the kernel doesn't have HT support, then it won't necessarily 
balance loads properly.


