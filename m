Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUGGQJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUGGQJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 12:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUGGQJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 12:09:14 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:8321 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265219AbUGGQJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 12:09:09 -0400
Message-ID: <40EC201C.2060906@nortelnetworks.com>
Date: Wed, 07 Jul 2004 12:09:00 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Tilley <bradtilley@usa.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Directory where modules are loacted in 2.6.7 build
References: <922iggP8L3328S17.1089215951@uwdvg017.cms.usa.net>
In-Reply-To: <922iggP8L3328S17.1089215951@uwdvg017.cms.usa.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Tilley wrote:
> This is probably a stupid question, but here goes:
> 
> When a normal user on a x86 PC builds a 2.6.x kernel in his home 
> directory by
> issuing the 'make' command where are the modules placed?

They're left where they are compiled.

To actually put them anywhere, you must do "make modules_install" as root.

Chris
