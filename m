Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbWBQAMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWBQAMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWBQAMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:12:25 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:60592 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750827AbWBQAMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:12:24 -0500
Date: Thu, 16 Feb 2006 18:11:58 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: can't loadkeys anymore? (was Re: Linux-2.6.15.4 login errors)
In-reply-to: <5GY5a-6RF-35@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43F514CE.1000006@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5GS9n-6wf-33@gated-at.bofh.it> <5GSjf-6Ia-29@gated-at.bofh.it>
 <5GY5a-6RF-35@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Flinchbaugh wrote:
> On Thu, Feb 16, 2006 at 09:28:25AM -0500, Dave Jones wrote:
>> On Thu, Feb 16, 2006 at 09:13:46AM -0500, linux-os (Dick Johnson) wrote:
>>  > After installing linux-2.6.15.4, attempts to log in a non-root
>>  > account gives these errors.
>>  > Password:
>>  > Last login: Thu Feb 16 08:53:20 on tty1
>>  > Keymap 0: Permission denied
>>  > Keymap 1: Permission denied
>>  > Keymap 2: Permission denied
>>  > LDSKBENT: Operation not permitted
>>  > loadkeys: could not deallocate keymap 3
>> It's coming from unicode_start
>>  > This is a RH Fedora base. Anybody know how to turn this crap off?
>> Apply updates.
>> This was fixed in kbd 1.12-10.fc4.1
> 
> This still leaves the question: Why is loadkeys no longer permitted to
> set the keymap for a tty the user currently owns?  What if the user
> really does want to run loadkeys without having to be root (ie. to load
> dvorak keymap)?
> 

I believe remapping keys on the console is no longer permitted for 
non-root users for security reasons, i.e. to prevent people from 
remapping keys so that the next person who logs in will unwittingly run 
specific commands with root privileges, etc.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

