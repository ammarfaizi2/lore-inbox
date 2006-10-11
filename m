Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWJKQb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWJKQb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWJKQb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:31:26 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:6210 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161121AbWJKQbY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:31:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=N80RDY2nPX6wubWocZXITmXNFK63btGGydHrzCSgDxzjK6MRIYJ3pZ0s1u+ozttZoXvLH1dkk9oCHw8ejIpZDWnPm5HmLQsYSyirwsUQur7H0xK+SL1o9qOEeMfSq8SOP3sWPC1qzRQ4zuvod/QnnlFO+KL1i15ndTieXJPqkLU=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Ismail Donmez <ismail@pardus.org.tr>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Thu, 12 Oct 2006 00:31:13 +0800
User-Agent: KMail/1.8.2
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Matt Domsch <Matt_Domsch@dell.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061011070412.GA6128@srcf.ucam.org> <200610111104.50563.ismail@pardus.org.tr>
In-Reply-To: <200610111104.50563.ismail@pardus.org.tr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610120031.13449.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 16:04, Ismail Donmez wrote:
> 11 Eki 2006 Çar 10:04 tarihinde, Matthew Garrett şunları yazmıştı:
> > On Wed, Oct 11, 2006 at 08:59:04AM +0200, Arjan van de Ven wrote:
> > > it'd also be nice if the linux-ready firmware developer kit had a test
> > > for this, so that we can offer 1) a way to test this to the bios guys
> > > and 2) encourage adding/note the lack easily
> >
> > Sure. Reading /proc/acpi/video/*/*/info should tell you whether a device
> > is an LCD or not.
>
> On my Sony Vaio with latest linux-2.6 git kernel it says its a CRT :
>
> [~]> cat  /proc/acpi/video/*/*/info
> device_id:    0x0100
> type:         CRT
> known by bios: no
> device_id:    0x0320
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0410
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0240
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0100
> type:         CRT
> known by bios: no
> device_id:    0x0111
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0118
> type:         UNKNOWN
> known by bios: no
> device_id:    0x0200
> type:         TVOUT
> known by bios: no
>
> So I don't think its reliable.
Please open a bug on bugzilla.kernel.org,
and post acpidump output. 

Thanks,
Luming

