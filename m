Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWE0LdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWE0LdE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 07:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWE0LdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 07:33:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50157 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751468AbWE0LdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 07:33:01 -0400
Message-ID: <447838EB.9060900@garzik.org>
Date: Sat, 27 May 2006 07:32:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
References: <4477B905.9090806@garzik.org> <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Attached to this email is chomp.pl, a Perl script which removes trailing
>> whitespace from several files.  I've had this for years, as trailing whitespace
>> is one of my pet peeves.
>>
>> Now that git-applymbox complains loudly whenever a patch adds trailing
>> whitespace, I figured this script may be useful to others.
>>
> 
> Pretty long script. How about this two-liner? It does not show 'bytes 
> chomped' but it also trims trailing whitespace.
> 
> #!/usr/bin/perl -i -p
> s/[ \t\r\n]+$//

Yes, it does, but a bit too aggressive for what we need :)

	Jeff



