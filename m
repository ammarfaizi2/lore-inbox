Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbUAQQOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 11:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbUAQQOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 11:14:08 -0500
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:24045 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S266074AbUAQQNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 11:13:05 -0500
Message-ID: <40095F0D.8070300@borgerding.net>
Date: Sat, 17 Jan 2004 11:13:01 -0500
From: Mark Borgerding <mark@borgerding.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
References: <Xine.LNX.4.44.0401161039480.20623-100000@thoron.boston.redhat.com> <40081AF0.5060907@borgerding.net> <bua7o7$ahj$1@abraham.cs.berkeley.edu>
In-Reply-To: <bua7o7$ahj$1@abraham.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:

>Mark Borgerding  wrote:
>  
>
>>James Morris wrote:
>>    
>>
>>>Eli Biham has suggested encrypting the sector numbers, see
>>>http://people.redhat.com/jmorris/crypto/cryptoloop_eli_biham.txt
>>>      
>>>
>>This does not defend against a dictionary attack.
>>    
>>
>
>Right.  It defends against a different attack.  It appears that
>there may be multiple weaknesses here...
>  
>
I couldn't google the original suggestion from Eli Biham.  The verbiage 
of the email ( hearsay, thrice removed ) seemed to indicate the proposal 
was to defend against a DA.

I'm curious. What attack would it defend against?  The extra IV of zeros 
might make it harder to attack a weak cipher with known plaintext 
through differential cryptanalysis, iff the first IV was mostly zeros  ( 
I'm grasping at straws here ).

That's about all I can think of. But then again; I wasn't on the Popular 
Science "Brilliant 10" list.
;^)  Belated Congratulations, David. 

- Mark




