Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288921AbSAIRzq>; Wed, 9 Jan 2002 12:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288923AbSAIRzg>; Wed, 9 Jan 2002 12:55:36 -0500
Received: from mail.myrio.com ([63.109.146.2]:17650 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S288921AbSAIRzd> convert rfc822-to-8bit;
	Wed, 9 Jan 2002 12:55:33 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: initramfs programs (was [RFC] klibc requirements)
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Wed, 9 Jan 2002 09:54:28 -0800
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB21@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: initramfs programs (was [RFC] klibc requirements)
Thread-Index: AcGY9KA9Cbi0GOqyRf6+aoWlydotEQAP7OvA
From: "Torrey Hoffman" <torrey.hoffman@myrio.com>
To: <andersen@codepoet.org>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The interesting thing that I currently do with initrd support is a
custom network-booted Linux installer for an embedded system. 

I'd like to be able to do this with initramfs too.  It needs:

- busybox, of course
- sfdisk  (scripted fdisk)
- mkreiserfs
- lilo
- dhcpcd
- A utility to display images in the framebuffer, like "fbv".

Torrey Hoffman
