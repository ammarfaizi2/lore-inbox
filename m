Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbULJDwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbULJDwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 22:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbULJDwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 22:52:13 -0500
Received: from ms-smtp-03-qfe0.socal.rr.com ([66.75.162.135]:59374 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S261581AbULJDwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 22:52:08 -0500
Message-ID: <41B91D62.20804@clones.net>
Date: Thu, 09 Dec 2004 19:52:02 -0800
From: Glendon Gross <gross@clones.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: linux-kernel@vger.kernel.org, glendon144@hotmail.com
Subject: Re: Burning CD's and 2.6.9
References: <Pine.NEB.4.44.0412090810570.27084-100000@bsd.clones.net> <41B88007.7060300@ppp0.net>
In-Reply-To: <41B88007.7060300@ppp0.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I initially posted the problem, I had no /dev/hdc device but now I 
have cleared that up by commenting out
the "append hdc=ide-scsi" line in /etc/lilo.conf.   I still need to do 
more testing to determine the cause of the lockups
I have been getting when trying to burn CD's under 2.6.9 with cdrecord.  
I may be using the wrong version of
cdrecord, but I noticed that the syntax   "cdrecord dev=/dev/hdc" does 
work, and is able to talk to the DVD writer.

Regards, 

Glendon Gross

Jan Dittmer wrote:

>Glendon Gross wrote:
>  
>
>>I just built 2.6.9 and have been playing with the config to try to enable
>>support for my EMPREX 8x DVD burner.  It works exceptionally well under
>>2.4.26.   I can use cdrecord and also growisofs to make audio and data
>>DVD's.
>>    
>>
>
>  
>
>>I've set up a lilo config menu to boot 2.6.9 or 2.4.26 because the device
>>is not recognized under 2.6.9.    When it is recognized, I get a warning
>>that ide-scsi is deprecated for cd recording.
>>    
>>
>
>You haven't stated what's wrong with 2.6.9. You know that you can
>just use cdrecord dev=/dev/<your ide device name> in 2.6? Without
>any SCSI mid-layer. Do you have a specific problem with that?
>
>Jan
>
>
>
>  
>




