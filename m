Return-Path: <linux-kernel-owner+w=401wt.eu-S932977AbWLSWdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbWLSWdL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932988AbWLSWdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:33:11 -0500
Received: from web32904.mail.mud.yahoo.com ([209.191.69.81]:41150 "HELO
	web32904.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932977AbWLSWdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:33:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=wrJajEVMrvIM78a320FWzXZ51k3evYJYC3aYT4CsmjvAyxapWb2edBydnNEEETOMKlku1wFN+NVOsFyImyud0Tef4eMXEo+p+cJQhR7xzQXGmQZpaqflgvu+yx4djceAn3oa4p18eCGzvzpQg4R0nprkLsv8Hi785sYUL3JUTFA=;
X-YMail-OSG: 6EHKnL0VM1mEXjAyGVeoyM8T7a.LcBQPwKsdrHU8DVGzdMqD6yRPNCXnOpnv2UtqJNpf2mqRrkqpIgIGN0MfBquKJt0mAORf1u49rO4beksQuc7DliOOcgukTdIeC0YukhPyFHOjY8T91DC43l1pTZTZNAI79TVEpSMH7vOjoYPqg9fwoUczYwLX3NvA
Date: Tue, 19 Dec 2006 14:33:09 -0800 (PST)
From: J <jhnlmn@yahoo.com>
Subject: Re: Possible race condition in usb-serial.c
To: linux-kernel@vger.kernel.org
In-Reply-To: <200612192113.40102.oliver@neukum.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <695571.36956.qm@web32904.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the response.

> This code depends on protection from BKL.

Really? I cannot find many lock_kernel calls in 
USB directory and those, which I can find, 
don't appear to protect usb_serial_disconnect
and serial_close from being called at the same time.

May be the protection is at a higher level? 
Personally I don't beleive it.
If you know how this thing is supposed to work,
please, tell me.

Thank you
John

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
