Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUAOPVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUAOPVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:21:16 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:21212 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S264246AbUAOPVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:21:13 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>,
       linux-kernel@vger.kernel.org
Subject: Re: True story: "gconfig" removed root folder...
References: <1074177405.3131.10.camel@oebilgen>
	<Pine.LNX.4.58.0401151558590.27223@serv>
From: Doug McNaught <doug@mcnaught.org>
Date: Thu, 15 Jan 2004 10:20:46 -0500
In-Reply-To: <Pine.LNX.4.58.0401151558590.27223@serv> (Roman Zippel's
 message of "Thu, 15 Jan 2004 16:05:59 +0100 (CET)")
Message-ID: <87ptdl2q7l.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

> On Thu, 15 Jan 2004, Ozan Eren Bilgen wrote:
>
>> Today I downloaded 2.6.1 kernel and tried to configure it with "make
>> gconfig". After all changes I selected "Save As" and clicked "/root"
>> folder to save in. Then I clicked "OK", without giving a file name. I
>> expected that it opens root folder and lists contents. But this magic
>> configurator removed (rm -Rf) my root folder and created a file named
>> "root". It was a terrible experience!..
>
> I only did a quick check with menuconfig. Are you sure it's really
> removed? It should still be there as "/root.old".
> I probably should change the behaviour of the save routine to behave
> differently for directories as argument, but it doesn't remove it.
> (Changing gconfig to only accept files in the save request would probably
> be nice too...)

The real lesson here is "don't compile your kernel as root".  There's
no need to do so.

-Doug
