Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263860AbUECSyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbUECSyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUECSwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:52:19 -0400
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:45483 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263871AbUECSv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:51:59 -0400
Message-ID: <4096948A.4010708@stesmi.com>
Date: Mon, 03 May 2004 20:50:50 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Nigel Cunningham <ncunningham@linuxmail.org>,
       Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere> <opr65f48sfshwjtr@laptop-linux.wpcb.org.au> <20040503124555.GB1188@openzaurus.ucw.cz>
In-Reply-To: <20040503124555.GB1188@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

>>Is that true? We can see where the oops occurs. If it's in the 
>>module,  nothing more needs to be said. If it's in the kernel itself, 
>>we can check  our source. We could check all the calls the module 
> 
> 
> We *could* do it, but it would take too much time and we
> have better stuff to do.

And we don't know if that module didn't overwrite memory (nVidia ..)
or anything else either. The the oops is really useless.

Of course, those cases are difficult to debug ANYWAY even if you have
the source but if it's binary you can't do squat.

// Stefan
