Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSJWRpX>; Wed, 23 Oct 2002 13:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265110AbSJWRpX>; Wed, 23 Oct 2002 13:45:23 -0400
Received: from webmail30.rediffmail.com ([202.54.124.145]:8173 "HELO
	webmail30.rediffmail.com") by vger.kernel.org with SMTP
	id <S265108AbSJWRpV>; Wed, 23 Oct 2002 13:45:21 -0400
Date: 23 Oct 2002 17:52:55 -0000
Message-ID: <20021023175255.547.qmail@webmail30.rediffmail.com>
MIME-Version: 1.0
From: "Ashwin  Sawant" <sawant_ashwin@rediffmail.com>
Reply-To: "Ashwin  Sawant" <sawant_ashwin@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Workqueues and the Nvidia driver
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have successfully compiled the latest Nvidia driver with kernel 
2.5.44 on a heavily modified RH 7.2 (original compiler) box  after 
applying the patch posted to this list previously. However it 
can't be loaded because insmod bombs out saying that, IIRC, 
create_workqueue, flush_workqueue, and a couple of other similar 
symbols are unresolved.
nm vmlinux shows that these symbols exist and this is (obviously) 
reflected in the System.map. However, the proc interface doesn't 
show them. I use modutils-2.4.6.
I'm not familiar with the internals but IMHO, this may be a 
problem with the kernel and not only with the Nvidia driver 
(hence, the reason for posting here).
Any advice/info would be appreciated.
TIA,
Ashwin.

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

