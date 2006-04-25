Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWDYLDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWDYLDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWDYLDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:03:44 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:61189 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932198AbWDYLDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:03:43 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: __FILE__ gets expanded to absolute pathname
Date: Tue, 25 Apr 2006 12:03:47 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200604251044.57373.vda@ilport.com.ua>
In-Reply-To: <200604251044.57373.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251203.47765.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 08:44, Denis Vlasenko wrote:
> Sometime ago I noticed that __FILE__ gets expanded into
> *absolute* pathname if one builds kernel in separate object directory.
>
> I thought a bit about it but failed to arrive at any sensible
> solution.
>
> Any thoughs?

Sounds to me like in-tree users of __FILE__ should be audited. Those using 
them for print statements about how unhappy they are should probably be 
revised to "drivername: <message>"..

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
