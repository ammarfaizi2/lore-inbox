Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265412AbSJXMwW>; Thu, 24 Oct 2002 08:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265416AbSJXMwV>; Thu, 24 Oct 2002 08:52:21 -0400
Received: from webmail30.rediffmail.com ([202.54.124.145]:39571 "HELO
	webmail30.rediffmail.com") by vger.kernel.org with SMTP
	id <S265412AbSJXMwV>; Thu, 24 Oct 2002 08:52:21 -0400
Date: 24 Oct 2002 12:59:51 -0000
Message-ID: <20021024125951.24497.qmail@webmail30.rediffmail.com>
MIME-Version: 1.0
From: "Ashwin  Sawant" <sawant_ashwin@rediffmail.com>
Reply-To: "Ashwin  Sawant" <sawant_ashwin@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Workqueues and the Nvidia driver
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding the problems with the nvidia driver on 2.5.44, the 
problem is, as Dave suggested, the GPL-only workqueues. I changed 
(for personal use) the relevant EXPORT_SYMBOL_GPLs to 
EXPORT_SYMBOLs in workqueue.c. It works quite fine even though it 
is a bit unstable.
Adding a MODULE_LICENSE("GPL") line to the nvidia driver would 
have been quicker but I don't somehow think that's allowed :)
Cheers,
Ashwin.

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

