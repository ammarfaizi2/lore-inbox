Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbUACWU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUACWUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:20:55 -0500
Received: from main.gmane.org ([80.91.224.249]:716 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264284AbUACWUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:20:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Re: 2.6.1rc1 fails to build on Alpha
Date: Sat, 3 Jan 2004 22:20:25 +0000 (UTC)
Organization: Complete.Org
Message-ID: <slrnbveg19.4er.jgoerzen@christoph.complete.org>
References: <slrnbvd1ci.2mp.jgoerzen@christoph.complete.org> <20040103184904.A3321@Marvin.DL8BCU.ampr.org>
X-Complaints-To: usenet@complete.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-01-03, Thorsten Kranzkowski <dl8bcu@dl8bcu.de> wrote:
>> local symbol 0: discarded in section `.exit.text' from drivers/built-in.o
>> local symbol 1: discarded in section `.exit.text' from drivers/built-in.o
>> make[1]: *** [.tmp_vmlinux1] Error 1
>
>> # CONFIG_HOTPLUG is not set
>
> I was able to eliminate these with 'Support for hot-pluggable devices'.

That did indeed fix it; thanks!

-- John

