Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUHKNxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUHKNxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 09:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268066AbUHKNxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 09:53:47 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:59301 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S268065AbUHKNxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 09:53:44 -0400
Message-ID: <411A2547.1090406@blue-labs.org>
Date: Wed, 11 Aug 2004 09:55:19 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       "David N. Welton" <davidw@eidetix.com>,
       Sascha Wilde <wilde@sha-bang.de>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <4107E788.8030903@eidetix.com> <41122C82.3020304@eidetix.com> <200408110131.14114.dtor_core@ameritech.net> <20040811122711.GA5759@ucw.cz>
In-Reply-To: <20040811122711.GA5759@ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------050505090809020508090106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050505090809020508090106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Vojtech Pavlik wrote:

> [...]
>
>>Hi,
>>
>>Could you please try the patch below? I am interested in tests both with
>>and without keyboard/mouse. The main idea is to leave ports that have been
>>disabled by BIOS alone... The patch compiles but otherwise untested. Against
>>2.6.7.
>>    
>>
>
>Well, this has a problem - plugging a mouse later will never work, as
>the interface will be disabled by the BIOS if a mouse is not present at
>boot.
>  
>

Hmm, this may be the design of the system, but from experience I can say 
that I've only had one computer that wouldn't later use a mouse or 
keyboard if it wasn't plugged in at boot.  All my systems for the last 
three years will happily boot with nothing plugged in and use a mouse 
and keyboard whenever you want to plug them in.  That one system that 
needed the mouse/keyboard plugged in at boot was Winblows.  It would 
work fine in Linux.

David


--------------050505090809020508090106
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


--------------050505090809020508090106--
