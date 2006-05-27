Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWE0LmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWE0LmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 07:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWE0LmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 07:42:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63981 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751467AbWE0LmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 07:42:02 -0400
Message-ID: <44783B08.1040803@garzik.org>
Date: Sat, 27 May 2006 07:42:00 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
References: <4477B905.9090806@garzik.org> <4477D2D9.5050001@zytor.com>
In-Reply-To: <4477D2D9.5050001@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Jeff Garzik wrote:
>>
>> Attached to this email is chomp.pl, a Perl script which removes 
>> trailing whitespace from several files.  I've had this for years, as 
>> trailing whitespace is one of my pet peeves.
>>
>> Now that git-applymbox complains loudly whenever a patch adds trailing 
>> whitespace, I figured this script may be useful to others.
>>
> 
> This is the script I use for the same purpose.  It's a bit more 
> sophisticated, in that it detects and avoids binary files, and doesn't 
> throw an error if it encounters a directory (which can happen if you 
> give it a wildcard.)

Chewing the EOF blanks is nice.  The only nit I have is that your script 
rewrites the file even if nothing was changed.

	Jeff



