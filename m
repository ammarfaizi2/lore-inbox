Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263910AbTCUXad>; Fri, 21 Mar 2003 18:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264126AbTCUXad>; Fri, 21 Mar 2003 18:30:33 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:62615 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP
	id <S263910AbTCUXad>; Fri, 21 Mar 2003 18:30:33 -0500
Message-ID: <3E7BA329.2060806@cox.net>
Date: Fri, 21 Mar 2003 16:41:29 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
References: <20030321014048.A19537@baldur.yggdrasil.com> <3E7B79D5.3060903@cox.net> <20030321232131.GA18010@kroah.com>
In-Reply-To: <20030321232131.GA18010@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>Are you still considering smalldevfs for 2.6 inclusion? If not, then I'd 
>>like to discuss with you (and Greg KH) the possibility of just eliminating 
>>devfs entirely, and moving to a userspace version that is driven entirely 
>>by /sbin/hotplug.
> 
> 
> You mean with something like this:
> 	http://www.linuxsymposium.org/2003/view_abstract.php?talk=94
> :)
> 

Yep, that's the one. Sounds very simple and straightforward to me. The most 
complex part will be defining some file structure to define the user's desired 
naming policy to the agent that handles the hotplug events.

