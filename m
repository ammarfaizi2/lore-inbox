Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVBVIBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVBVIBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 03:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVBVIBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 03:01:41 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:27932 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262241AbVBVIBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 03:01:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tWpF7cCedNMaPAO275XDNOpqDpLXrSIE76RU7mHmHdQRPljFGY7avrBOEio26S8Qw3i5n5kBdRJsTwivkcX5HqlnrwTFBMiNIA9n0MUBDgFb5AKnTLROw5sfGUI0hvvg019Vm1pPLnhCbrzT0sVWoG7d9zcz8/rJ1t8hiSXwH6A=
Message-ID: <421AE6D3.7060105@gmail.com>
Date: Tue, 22 Feb 2005 13:31:23 +0530
From: Inguva <inguva@gmail.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux lover <linux_lover2004@yahoo.com>
CC: linux-kernel@vger.kernel.org, lkg india <lkg_india@yahoogroups.com>
Subject: Re: Which types of functions are exported by kernel source?
References: <20050222073808.2221.qmail@web52210.mail.yahoo.com>
In-Reply-To: <20050222073808.2221.qmail@web52210.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>/proc/ksyms. But if function in kernel source is not
>defined with asmlinkage then it is exported to kernel
>and seen in /proc/ksyms.
>      Is that correct??
>  
>
I dont think so. Only symbols explicitly exported via EXPORT_SYMBOL
macro are exported. asmlinkage keyword has nothing to do with symbol
exporting.

Regards,
Inguva
