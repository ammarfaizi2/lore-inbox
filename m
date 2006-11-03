Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWKCVmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWKCVmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWKCVmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:42:54 -0500
Received: from nz-out-0102.google.com ([64.233.162.199]:17715 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932135AbWKCVmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:42:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=S0r38TlEnpMyTF79topfBHjkdrZZ9pfsBlWynVChis6qqYoVQLhOLEQw/wGllUrgyyaxJY2paRXjdayVNJsLKzakFKzbU4T3/sIY5RowWMIhnCPxf5qbSbk1yrQDvWGMu4DN7Gk8GuvpX6aq7AjCZ7iSgRea2Pw+bky/C3v6Gn0=
Reply-To: andrew.j.wade@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc4-mm2
Date: Fri, 3 Nov 2006 16:42:33 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061101235407.a92f94a5.akpm@osdl.org>
In-Reply-To: <20061101235407.a92f94a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611031642.36558.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2006 02:54, Andrew Morton wrote:
> - Lots of fbdev updates.  We haven't heard from Tony in several months, so I
>   went on a linux-fbdev-devel fishing expedition.

radeonfb-support-24bpp-32bpp-minus-alpha.patch broke my video: my
screen ended up garbled. (vc1 was ok, strangely enough). Reverting
fixed things. 

lspci -v:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7500
        Flags: bus master, stepping, 66MHz, medium devsel, latency 64, IRQ 16
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fe0000 [disabled] [size=128K]
        Capabilities: <available only to root>

-ajw
