Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbVLSJgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVLSJgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 04:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVLSJgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 04:36:23 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:58016 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932675AbVLSJgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 04:36:23 -0500
Message-ID: <43A67FFD.2030202@aitel.hist.no>
Date: Mon, 19 Dec 2005 10:40:13 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Steven Rostedt <rostedt@goodmis.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Lee Revell <rlrevell@joe-job.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <200512170016.jBH0GQE3004715@quelen.inf.utfsm.cl>
In-Reply-To: <200512170016.jBH0GQE3004715@quelen.inf.utfsm.cl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>>So people should really be asking for a PAGE_SIZE = 8k option ;)
>>    
>>
>
>On i386 is is either 4KiB or 4MiB. Guess what I prefer...
>  
>
Well, you can always use 8k pages - by setting PAGE_SIZE to 8k
and always set up the real 4k pages in pairs.  Wheter we want to do this
is another issue - but it is simple enough and avoids fragmentation.

Helge Hafting
