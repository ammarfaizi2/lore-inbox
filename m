Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUCOBYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 20:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUCOBYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 20:24:32 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:15734 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262089AbUCOBYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 20:24:30 -0500
Message-ID: <405505CC.3090407@blueyonder.co.uk>
Date: Mon, 15 Mar 2004 01:24:28 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2004 01:24:29.0225 (UTC) FILETIME=[4301D990:01C40A2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis . Kletnieks wrote:
 > On Fri, 12 Mar 2004 18:24:01 GMT, Adam Jones 
<adam@xxxxxxxxxxxxxxxxxxxx> said:
 >>/ In a futile gesture against entropy, Sid Boyce wrote:/
 >>/ > Max Valdez wrote:/
 >>/ /
 >>/ > >Been using nvidia modules for quite a few 2.6.x kernels, most of 
them mmX./

 >>/ > >without problems/
 >/> /
 >>/ I'm using it here with 2.6.4, no problems as yet./
 >>/ /
 >>/ > Something strange happened, I shall try 2.6.4-mm1 shortly to see 
if it /
 >>/ > is still the same. I reckon though that I've suffered a filesystem /
 >>/ > corruption./
 >>/ /
 >>/ A quick thought - have you got CONFIG_REGPARM enabled in the kernel/
 >>/ config? If so, disable it and try again. (It's almost certain to/
 >>/ cause crashes with binary modules.)/

 > Also, the NVidia driver uses a bit of kernel stack, so it's incompatible
 > with the CONFIG_4KSTACKS option in recent -mm kernels...

I have that enabled, so I shall turn it off. /var/log/XFree86.0.log 
shows it's getting so far then the lockup happens.
(==) ModulePath set to "/usr/X11R6/lib/modules"
(**) Option "AllowMouseOpenFail"
(**) Option "Xinerama" "off"
(**) Option "RandR" "on"
(++) using VT number 7

(WW) Open APM failed (/dev/apm_bios) (No such device)
(II) Module ABI versions:
        XFree86 ANSI C Emulation: 0.2
        XFree86 Video Driver: 0.6
        XFree86 XInput driver : 0.4
        XFree86 Server Extension : 0.2
        XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

