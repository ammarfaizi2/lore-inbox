Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWFRLL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWFRLL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWFRLL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:11:28 -0400
Received: from mail-ale01.alestra.net.mx ([207.248.224.149]:61403 "EHLO
	mail-ale01.alestra.net.mx") by vger.kernel.org with ESMTP
	id S1751146AbWFRLL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 07:11:27 -0400
Message-ID: <449534DA.8040103@att.net.mx>
Date: Sun, 18 Jun 2006 06:11:22 -0500
From: Hugo Vanwoerkom <rociobarroso@att.net.mx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: ck@vds.kolivas.org, linux list <linux-kernel@vger.kernel.org>
Subject: Re: sound skips on 2.6.16.17
References: <4487F942.3030601@att.net.mx> <200606172129.56986.kernel@kolivas.org> <20060618024130.GA32399@tuatara.stupidest.org> <200606181204.29626.ocilent1@gmail.com> <20060618044047.GA1261@tuatara.stupidest.org>
In-Reply-To: <20060618044047.GA1261@tuatara.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sun, Jun 18, 2006 at 12:04:29PM +0800, ocilent1 wrote:
>
>   
>> (PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch)
>> that is causing the sound stuttering/skipping problems for our users
>> with VIA chipsets. Backing out the first patch alone did not fix the
>> problem (PCI-VIA-quirk-fixup-additional-PCI-IDs.patch) but to back
>> out the 2nd patch, you need to have initially backed out the first
>> patch, due to the way the patches apply in series.
>>     
>
> what mainboard/CPU do you have there?
>
> what does 'lspci -n' say?
>
>   

/home/hugoSun Jun 18-06:08:30HDC1# lspci -n
0000:00:00.0 0600: 1106:0269
0000:00:00.1 0600: 1106:1269
0000:00:00.2 0600: 1106:2269
0000:00:00.3 0600: 1106:3269
0000:00:00.4 0600: 1106:4269
0000:00:00.7 0600: 1106:7269
0000:00:01.0 0604: 1106:b198
0000:00:0a.0 0300: 10de:0181 (rev a2)
0000:00:0b.0 0104: 1095:3112 (rev 02)
0000:00:0c.0 0401: 1102:0007
0000:00:0f.0 0101: 1106:0571 (rev 06)
0000:00:10.0 0c03: 1106:3038 (rev 81)
0000:00:10.1 0c03: 1106:3038 (rev 81)
0000:00:10.2 0c03: 1106:3038 (rev 81)
0000:00:10.3 0c03: 1106:3038 (rev 81)
0000:00:10.4 0c03: 1106:3104 (rev 86)
0000:00:11.0 0601: 1106:3227
0000:00:11.5 0401: 1106:3059 (rev 60)
0000:00:12.0 0200: 1106:3065 (rev 78)
0000:01:00.0 0300: 10de:0185 (rev c1)


