Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVAITmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVAITmB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVAITmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:42:00 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:28880 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261732AbVAITlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:41:53 -0500
Message-ID: <41E188FE.7010609@tomt.net>
Date: Sun, 09 Jan 2005 20:41:50 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printf() overhead
References: <41E18522.7060004@comcast.net>
In-Reply-To: <41E18522.7060004@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> using strace to run a program takes aeons.  Redirecting the output to a
> file can be a hundred times faster sometimes.  This raises question.
> 
> I understand that output to the screen is I/O.  What exactly causes it
> to be slow, and is there a possible way to accelerate the process?

The terminal is a major factor; gnome-terminal for example can be 
*extremely* slow.
