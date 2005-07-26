Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVGZXlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVGZXlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVGZXit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:38:49 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45779 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262297AbVGZXfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:35:31 -0400
Date: Tue, 26 Jul 2005 17:34:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PATCH: Assume PM Timer to be reliable on broken board/BIOS
In-reply-to: <4uGpt-2Y3-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42E6C86F.3010503@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4uGpt-2Y3-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Fourdan wrote:
> Hi all,
> 
> 
> Background
> ==========
> 
> I have a laptop (Compaq R3480EA, AMD 64 3400+ with NForce3) and reported
> multiple problems related to timer issues.
> 
> In a nutshell, sometimes, the PIT/TSC timer runs 3x too fast [1]. That
> causes many issues, including DMA errors, MCE, and clock running way too
> fast (making the laptop unusable for any software development). So far,
> no BIOS update was able to fix the issue for me.

Shouldn't this be looked into further rather than adding this 
workaround? Surely Windows is using the PIT as well, so there must be 
some way to get it to behave properly..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


