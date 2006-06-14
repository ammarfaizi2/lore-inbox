Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWFNELQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWFNELQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 00:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFNELQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 00:11:16 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:13441 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751218AbWFNELP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 00:11:15 -0400
Message-ID: <448F8C53.5010406@ens-lyon.org>
Date: Wed, 14 Jun 2006 00:10:59 -0400
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: Russell Whitaker <russ@ashlandhome.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.19 + gcc-4.1.1
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org> <3aa654a40606132049u43f81ee1m263ee15666246152@mail.gmail.com>
In-Reply-To: <3aa654a40606132049u43f81ee1m263ee15666246152@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
> On 6/13/06, Russell Whitaker <russ@ashlandhome.net> wrote:
>> Then, after mrproper, rebuilt with gcc-4.1.1, no other changes.
>>    compiles ok, installs ok. But, when attempting to load a module, get
>>    the following message:  version magic '2.6.16.19via K6 gcc-4.1',
>>    should be '2.6.16.19via 486 gcc-3.3'
>
> You may have forgotten to "make modules modules_install"

Actually, "make modules" does not exist anymore with 2.6. Both built-in
and modular stuff are built at the same time.
Only "make modules_install" is still required.

Brice

