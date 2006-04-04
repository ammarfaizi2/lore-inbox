Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWDDCbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWDDCbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWDDCbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:31:40 -0400
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:36044 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S964972AbWDDCbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:31:39 -0400
Message-ID: <4431DA7D.80907@jg555.com>
Date: Mon, 03 Apr 2006 19:31:25 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Header Sanitizing Project
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on a way to sanitize the headers. I've come up with a 
process, that works for what I do, and hope to expand it with all the 
positive feedback I've been getting. The product of this research is at 
http://ftp.jg555.com/headers/headers2, and has a requirement of unifdef, 
which is listed in the script itself.

When I was working on this project, I've noticed a lot of headers are 
missing minor little things. Example. most if the if_*.h files are 
missing asm/types.h. linux/input.h has a complete procedure that should 
be under __KERNEL__. Should I submit these as bugs along with the 
patches? I have no problem submitting them.

Please advise me on the proper procedure on the findings, I can provide 
more details, but everything is in my little script for sanitizing the 
headers.

Thank you for all your help

Jim Gifford
maillist@jg555.com
