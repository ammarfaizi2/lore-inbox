Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266253AbUFPL4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUFPL4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUFPL4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:56:25 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:3446 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266253AbUFPL4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:56:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 'uinput' Oops upon select() or poll() on 2.6.7
Date: Wed, 16 Jun 2004 06:56:21 -0500
User-Agent: KMail/1.6.2
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <xb7ekp4cw4o.fsf@savona.informatik.uni-freiburg.de> <xb7wu27spm8.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7wu27spm8.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200406160656.21866.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 June 2004 06:34 am, Sau Dan Lee wrote:
> 
> But the bug is STILL in 2.6.7.  I don't understand.  What are the -rc*
> supposed for, if bugs do not get fixed?
> 

Hi,

Given the fact that it affects exactly one person and you can avoid it by
fixing your program which is broken in this regard anyway (why would you
poll device before you create it?) I don't think it is that urgent...

I believe it will be merged when Linus does next pull. 

-- 
Dmitry
