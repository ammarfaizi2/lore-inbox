Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUAYSFF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUAYSFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:05:04 -0500
Received: from main.gmane.org ([80.91.224.249]:45037 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265114AbUAYSE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:04:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
Date: Sun, 25 Jan 2004 19:04:56 +0100
Message-ID: <yw1xptd752gn.fsf@ford.guide>
References: <4013D155.3080900@freesurf.ch> <87y8rw2eyy.fsf@devron.myhome.or.jp>
 <40140221.40901@freesurf.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:8BW/2MuaXNPd5wylduRS1V/UJYQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Mongenet <Marc.Mongenet@freesurf.ch> writes:

> OGAWA Hirofumi wrote:
>> Marc Mongenet <Marc.Mongenet@freesurf.ch> writes:
>>
>>>Hi, I have a Minolta DiMAGE F100 camera and two memory cards,
>>>a 16 MB and a 128 MB.
>>>With kernel 2.2.25 I can mount the 16 MB but not the 128 MB.
>>>With kernel 2.4.16 to 2.4.25pre6 I can mount the 128 MB but not the 16 MB.
>>>With kernel 2.4.25pre7 I can mount the 16 MB but not the 128 MB.
>>>
>>>There is probably something special with the filesystem used by Minolta
>>>because I have to format it with the camera to be recognized by the camera.
>> What error did you get? Please send output of dmesg and first
>> 256KB of 128MB card.
>
> Well, 10 minutes after finally reporting the problem, I discovered that
> it is different than described above...
>
> So, I can mount the 16 MB card or the 128 MB card with any kernel,
> BUT I have to reboot the system when I change the cards. Example:

I have to reload the sd-mod module when changing cards.  Have you
tried that?

-- 
Måns Rullgård
mru@kth.se

