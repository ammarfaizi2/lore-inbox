Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWFLWEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWFLWEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWFLWEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:04:08 -0400
Received: from mail.mazunetworks.com ([4.19.249.111]:47784 "EHLO
	mail.mazunetworks.com") by vger.kernel.org with ESMTP
	id S932427AbWFLWEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:04:07 -0400
Message-ID: <448DE4F1.9000407@mazunetworks.com>
Date: Mon, 12 Jun 2006 18:04:33 -0400
From: Jeff Gold <jgold@mazunetworks.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial Console and Slow SCSI Disk Access?
References: <448DDC7F.4030308@mazunetworks.com> <448DDF1D.5020108@rtr.ca>
In-Reply-To: <448DDF1D.5020108@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> This can happen if there are kernel messages being printed on the serial 
> console.
> If all is quiet, I would expect things to be as fast as normal elsewhere.

Thank you for the suggestion.  I don't see much in /var/log/messages 
(syslogd is running).  There are 3326 lines taking up about 256 kB 
there, and when I run hdparm runs no further messages are generated.

I don't have anything attached to the serial port at the moment.  Could 
that cause problems?  I'm going to attach something and see what 
happens.  Other advice is still welcome.

                                         Jeff
