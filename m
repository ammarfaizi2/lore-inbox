Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUEFSC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUEFSC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUEFSC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:02:59 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:10871 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261779AbUEFSC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:02:57 -0400
Date: Thu, 6 May 2004 20:08:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: dongzai007@sohu.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: beginner of a driver-developer
Message-ID: <20040506180853.GB2034@mars.ravnborg.org>
Mail-Followup-To: dongzai007@sohu.com, linux-kernel@vger.kernel.org
References: <7475352.1083848708542.JavaMail.postfix@mx0.mail.sohu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7475352.1083848708542.JavaMail.postfix@mx0.mail.sohu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 09:05:08PM +0800, dongzai007@sohu.com wrote:
> I am a beginner of a driver-developer.
> I got some problems.
> 
> you know some structs such as "file_operation" were defined in Header Files.when I define a struct in .C files,i always got errors below:
> 
> fops has an incomplete type
> storage size of 'fops' isn't known
> 
> In my .C files , I defined as followed:
> 
> .....................
> struct file_operation fops;
> .....................
> 
> How can i solve this sort of problems. Thank you.

In this particular case you did not include the header file that defines the
file_operations struct.
May I suggest you read "Linux Device drivers" by Jonathan Corbet.
It's available somewhere on the net, but I can recommend the paper version.
On lwn.net there is also a nice series of articles refelcting the changes
from 2.4 -> 2.6, also made by said Jonathan Corbet.


	Sam
