Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTJ2GDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 01:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTJ2GDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 01:03:09 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:14030 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261877AbTJ2GDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 01:03:07 -0500
Message-ID: <3F9F5812.7070509@nortelnetworks.com>
Date: Wed, 29 Oct 2003 01:02:58 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mouse really slow in 2.6.0-test9
References: <3F9F46B7.3050805@sympatico.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> I too am having issues with the mouse in test9.  It's horribly slow. 
> Obviously something is not working properly.
> 
> I've got an Intellimouse Explorer, original generation, connected via 
> ps/2.  No KVM.

Just a followup.  Backing out the changes Linus made to psmouse-base.c 
fixes the problem.


Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

