Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTJBSvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTJBSvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:51:17 -0400
Received: from opersys.com ([64.40.108.71]:58381 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S263444AbTJBSvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:51:11 -0400
Message-ID: <3F7C7455.1080403@opersys.com>
Date: Thu, 02 Oct 2003 14:54:13 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Hans-Georg Thien <1682-600@onlinehome.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: getting timestamp of last interrupt?
References: <3EB19625.6040904@onlinehome.de>	<3EBAAC12.F4EA298D@hp.com>	<3ED3CECA.9020706@onlinehome.de> <20030527231026.6deff7ed.subscript@free.fr> <3F7C6319.4010407@onlinehome.de>
In-Reply-To: <3F7C6319.4010407@onlinehome.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hans-Georg Thien wrote:
> I am looking for a possibility to read out the last timestamp when an 
> interrupt has occured.
> 
> e.g.: the user presses a key on the keyboard. Where can I read out the 
> timestamp of this event?
> 
> To be more precise, I 'm looking for
> 
> ( )a function call
> ( ) a callback where I can register to be notified when an event occurs
> ( ) a global accessible variable
> ( ) a /proc entry
> 
> or something like that.
> 
> Any ideas ?

Have a look at the Linux Trace Toolkit:
http://www.opersys.com/LTT/
It records micro-second time-stamps for quite a few events, including
interrupts.

HTH,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

