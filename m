Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUFKAcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUFKAcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 20:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUFKAcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 20:32:51 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:27811 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S263609AbUFKAct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 20:32:49 -0400
Message-ID: <40C8FDB7.5050102@blue-labs.org>
Date: Thu, 10 Jun 2004 20:32:55 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040609
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: USB HID failure, 2.6.7-rc2
Content-Type: multipart/mixed;
 boundary="------------000905020506040807020404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000905020506040807020404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

After some unknown event happens, I lose my USB mouse and dmesg starts 
filling up with the following message:

    drivers/usb/input/hid-core.c: control queue full

I'm moving to -rc3 this evening - hoping this bug is gone then.  There 
are no other messages prior to this other than the broken ALSA stuff, 
but that happens since boot anyways.  The machine had been up for almost 
24 hours (random instant lockups/reboots, sometimes an hour, sometimes 
two days) before this happened.  I was away for the day so the machine 
had been idle for almost 14 hours.  Unplugging and replugging this mouse 
has zero effect, the action isn't even noticed by the computer.

David


--------------000905020506040807020404
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------000905020506040807020404--
