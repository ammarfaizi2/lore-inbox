Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbUC2Tju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUC2Tju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:39:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:14821 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262880AbUC2Tjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:39:48 -0500
X-Authenticated: #1444759
Message-ID: <40687B75.3090709@gmx.de>
Date: Mon, 29 Mar 2004 21:39:33 +0200
From: Bernd Fuhrmann <silverbanana@gmx.de>
Reply-To: silverbanana@gmx.de
Organization: Private
User-Agent: Mozilla Thunderbird 0.5+ (Windows/20040317)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: usage of RealTek 8169 crashes my Linux system
References: <40673495.3050500@gmx.de> <4067378B.7070102@pobox.com> <4067489E.2090400@gmx.de> <20040329003600.A24995@electric-eye.fr.zoreil.com>
In-Reply-To: <20040329003600.A24995@electric-eye.fr.zoreil.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Bernd Fuhrmann <silverbanana@gmx.de> :
> 
>>If you think one of these patches might fix it (please tell me the exact 
>>patch number) I will apply and test it as soon as possible.
> 
> 
> Please try any recent -mm.
> 
> nmi_watchdog and magic sysrq are your friends. Don't expect much from
> syslog though.
> 
> Once you have applied -mm patch, you may apply the attached patch as well
> to help debugging.

I wasn't (yet) able to apply your patch (there were some errors and I'm 
not so firm about patching files manually). I don't have physical access 
to that computer anyway right now. So I'm not able to see any messages 
on it's console. But I applied the 2.6.5rc2-mm4 patch. Still the same 
problem. Linux still crashes after a couple of MBytes have passed the r8169.

Thanks for your effort. Any other idea how to fix that problem (like 
doing things that make r8169 stable while loosing performance)?

TIA
Bernd Fuhrmann
