Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265174AbUAJHwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 02:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbUAJHwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 02:52:40 -0500
Received: from ns.clanhk.org ([69.93.101.154]:28294 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265174AbUAJHwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 02:52:39 -0500
Message-ID: <3FFF59A0.2080503@clanhk.org>
Date: Sat, 10 Jan 2004 01:47:12 +0000
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Q re /proc/bus/i2c
References: <200401100117.42252.gene.heskett@verizon.net>
In-Reply-To: <200401100117.42252.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>Greetings;
>
>I'm still trying to make sensors (and gkrellm) work when booted to a  
>2.6.x kernel.
>
>The lm_sensors people say it should "just work", but so far no one has 
>acknowledged that it doesn't work here because I don't have an "i2c" 
>in my /proc/bus directory.  Browsing all the sensors-detection stuff, 
>in particular the bus detection script, this thing is hard coded to 
>look for /proc/bus/i2c by default, or you can pass it an argument.
>
>I don't have a "/proc/bus/i2c".  Passing this script the /sys/bus/i2c 
>argument only gets an error return complaining that its a directory.
>  
>

You've run the "sensors-detect" script and have all the proper modules 
loaded for your hardware?  You should be able to just run "sensors" to 
see if everything is working.

-ryan

