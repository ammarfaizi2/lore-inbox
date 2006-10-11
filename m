Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWJKIEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWJKIEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 04:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWJKIEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 04:04:43 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:40110 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161016AbWJKIEl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 04:04:41 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Wed, 11 Oct 2006 11:04:48 +0300
User-Agent: KMail/1.9.4
Cc: Arjan van de Ven <arjan@infradead.org>, Yu Luming <luming.yu@gmail.com>,
       Matt Domsch <Matt_Domsch@dell.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <1160549944.3000.347.camel@laptopd505.fenrus.org> <20061011070412.GA6128@srcf.ucam.org>
In-Reply-To: <20061011070412.GA6128@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610111104.50563.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11 Eki 2006 Çar 10:04 tarihinde, Matthew Garrett şunları yazmıştı: 
> On Wed, Oct 11, 2006 at 08:59:04AM +0200, Arjan van de Ven wrote:
> > it'd also be nice if the linux-ready firmware developer kit had a test
> > for this, so that we can offer 1) a way to test this to the bios guys
> > and 2) encourage adding/note the lack easily
>
> Sure. Reading /proc/acpi/video/*/*/info should tell you whether a device
> is an LCD or not. 

On my Sony Vaio with latest linux-2.6 git kernel it says its a CRT :

[~]> cat  /proc/acpi/video/*/*/info
device_id:    0x0100
type:         CRT
known by bios: no
device_id:    0x0320
type:         UNKNOWN
known by bios: no
device_id:    0x0410
type:         UNKNOWN
known by bios: no
device_id:    0x0240
type:         UNKNOWN
known by bios: no
device_id:    0x0100
type:         CRT
known by bios: no
device_id:    0x0111
type:         UNKNOWN
known by bios: no
device_id:    0x0118
type:         UNKNOWN
known by bios: no
device_id:    0x0200
type:         TVOUT
known by bios: no

So I don't think its reliable.

Regards,
ismail
